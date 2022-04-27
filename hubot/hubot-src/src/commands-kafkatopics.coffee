# Description:
#   Query or modify the state of Kafka topics
#
# Dependencies:
#   "kafka-impact-demo": "0.0.5"
#
# Configuration:
#   HUBOT_KAFKA_CLUSTER_NAME - default name of the Kafka cluster to manage
#   HUBOT_KAFKA_BOOTSTRAP - default bootstrap address for connecting to the Kafka cluster
#
# Commands:
#   hubot kafka can I restart brokers - explain impact of restarting each broker
#   hubot kafka show me <filter> topics - display info about topic partitions
#
# Author:
#   dalelane

KafkaImpact = require "kafka-impact-demo"

Config = require "./config"
Roles = require "./auth-roles"


module.exports = (@robot) ->

    getClusterConfig = (res) ->
        return {
            Bootstrap : Config.getBootstrap(res),
            ClusterName : Config.getClusterName(res),
            NumberOfKafkaBrokers : 4,
            DefaultReplicationFactor : 2,
            MinimumISR : 1
        }


    robot.respond /kafka\s*(?:show|get)\s*(?:me)?\s*(all|out of sync)\s*topics\s*(with details)?\s*/i, (res) ->
        robot.logger.debug "kafka show topics"
        if !robot.auth.hasRole(res.envelope.user, Roles.READ_ONLY)
            return res.reply "Sorry! You can't ask me for Kafka topic information."

        filter = res.match[1]
        includeReplicas = res.match[2]

        conf = getClusterConfig res
        KafkaImpact.detailedInfo(conf)
            .then (resp) ->
                message = resp.message

                resp.rows.sort (a, b) ->
                    [aname, bname] = [a.name, b.name]
                    if aname > bname then 1 else if aname < bname then -1 else 0

                for data in resp.rows
                    if filter == "all" or (filter == "out of sync" and data.outOfSync)
                        message += "\n`" + data.name + "`"
                        if includeReplicas
                            message += "  _leader:_ " + data.leader
                            message += "  _replicas:_ " + data.allReplicas.join(",")
                            message += "  _in-sync:_ " + data.inSyncReplicas.join(",")
                return res.reply message
            .catch (err) ->
                robot.logger.error err
                return res.reply "Sorry! I couldn't get the Kafka topic information"


    robot.respond /kafka\s*can\s*i\s*restart\s*brokers\s*/i, (res) ->
        robot.logger.debug "kafka can I restart brokers"
        if !robot.auth.hasRole(res.envelope.user, Roles.READ_ONLY)
            return res.reply "Sorry! You can't ask me for Kafka topic information."

        conf = getClusterConfig res
        KafkaImpact.runCheck(conf)
            .then (resp) ->
                message = resp.warning + " " + resp.header
                for data in resp.panelData
                    message += "\n *#{data.name}*  - #{data.label}"
                return res.reply message
            .catch (err) ->
                robot.logger.error err
                return res.reply "Sorry! I couldn't get the Kafka topic information"

