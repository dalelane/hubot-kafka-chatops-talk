# Description:
#   Query or modify the Kafka cluster configuration
#
# Dependencies:
#   "request": "2.88.2"
#
# Configuration:
#   HUBOT_KAFKA_K8S_NAMESPACE - default namespace where Kafka is running
#   HUBOT_KAFKA_CLUSTER_NAME - default name of the Kafka cluster to manage
#
# Commands:
#   hubot kafka get config - get the Kafka cluster config
#   hubot kafka get config <config> - get the details of a Kafka cluster config value
#   hubot kafka set config <config> - modify a Kafka cluster config value
#
# Author:
#   dalelane

Config = require "./config"
KubeApi = require "./kubeapi"
KafkaDocs = require "./kafkadocs"
Roles = require "./auth-roles"


module.exports = (@robot) ->

    kubeapi = new KubeApi()


    #
    #
    #

    robot.respond /kafka\s*get\s*(?:kafka)?\s*config\s*(\S+)?\s*/i, (res) ->
        robot.logger.debug "kafka get config"

        if !robot.auth.hasRole(res.envelope.user, Roles.READ_ONLY)
            return res.reply "Sorry! You can't ask me for Kafka config info."

        configkey = res.match[1]

        path = strimziUrl res
        kubeapi.get { path }, (err, resp) ->
            if err
                robot.logger.error path
                robot.logger.error err
                return res.reply "Sorry! I couldn't get the Kafka cluster config info"

            if !configkey?
                replytext = "The following overrides have been applied to the Kafka cluster:\n"
                for ck, cv of resp.spec.kafka.config
                    replytext += "  `#{ck}` = *`#{cv}`*\n"
                return res.reply replytext

            if configkey.startsWith "http://"
                # slack has unhelpfully recognised a dotted-config key as a URL
                #  (e.g. user said "delivery.timeout.ms" but slack sent us "http://delivery.timeout.ms")
                configkey = configkey.substr 7

            configvalue = resp.spec.kafka.config[configkey]
            configdocs = KafkaDocs.info configkey

            if !configvalue?
                configvalue = configdocs.defaultval

            reply =
                unfurl_links : false
                unfurl_media : false
                blocks : JSON.stringify ([
                    {
                        "type": "section"
                        "text":
                            "type": "mrkdwn"
                            "text": "`#{configkey}` is set to *`#{configvalue}`*"
                    },
                    {
                        "type": "section"
                        "text":
                            "type": "mrkdwn"
                            "text": "*Default:*\n`#{configdocs.defaultval}`"
                    },
                    {
                        "type": "section"
                        "text":
                            "type": "mrkdwn"
                            "text": "*Summary:*\n#{configdocs.summary}"
                    },
                    {
                        "type": "section"
                        "text":
                            "type": "mrkdwn"
                            "text": "*More info:*\n#{configdocs.moreinfo}"
                    }
                ])

            return res.send reply

    #
    #
    #


    robot.respond /kafka\s*set\s*(?:kafka)?\s*config\s*(\S+)\s*(?:to)?\s*(\S+)\s*/i, (res) ->
        robot.logger.debug "kafka set config"

        if !robot.auth.hasRole(res.envelope.user, Roles.MODIFY)
            return res.reply "Sorry! You can't ask me to modify Kafka config."

        configkey = res.match[1].trim()
        configvalue = res.match[2].trim()

        if configkey.startsWith "http://"
            # slack has unhelpfully recognised a dotted-config key as a URL
            #  (e.g. user said "delivery.timeout.ms" but slack sent us "http://delivery.timeout.ms")
            configkey = configkey.substr 7

        # use the default value to guess what type we should cast the
        #  provided string config value to
        configdocs = KafkaDocs.info configkey
        if Number.isInteger configdocs.defaultval
            configvalue = parseInt configvalue, 10
        else if typeof configdocs.defaultval == "boolean"
            configvalue = (configvalue.toLowerCase() == "true")

        value = strimziSpec Config.getClusterName(res)
        value.spec.kafka.config[configkey] = configvalue

        path = strimziUrl res
        kubeapi.patch { path, value }, (err, resp) ->
            if err
                robot.logger.error path
                robot.logger.error err
                return res.reply "Sorry! I couldn't modify the Kafka cluster config"

            return res.reply "Okay, I've set `#{configkey}` to `#{configvalue}`"


    #
    #
    #


    strimziUrl = (res) ->
        namespace = Config.getNamespace(res)
        instance = Config.getClusterName(res)
        return "/apis/kafka.strimzi.io/v1beta2/namespaces/#{namespace}/kafkas/#{instance}"

    strimziSpec = (name) ->
        return {
            apiVersion : 'kafka.strimzi.io/v1beta2'
            kind: 'Kafka'
            metadata: { name },
            spec : {
                kafka : {
                    config : {}
                }
            }
        }

