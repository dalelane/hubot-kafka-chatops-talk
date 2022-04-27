# Description:
#   Query the Hubot for the config it is using, and allow config changes
#
# Configuration:
#   HUBOT_KAFKA_K8S_NAMESPACE - default namespace where Kafka is running
#   HUBOT_KAFKA_CLUSTER_NAME - default name of the Kafka cluster to manage
#   HUBOT_KAFKA_BOOTSTRAP - default bootstrap address for connecting to the Kafka cluster
#   HUBOT_GRAFANA_HOST - URL for Grafana
#   HUBOT_GRAFANA_ORG_ID - org ID for Grafana API calls
#   HUBOT_GRAFANA_API_KEY - API key for querying Grafana
#
# Commands:
#   hubot kafka config - display all config
#   hubot kafka cluster ns - ask the namespace where the Kafka cluster is running
#   hubot kafka cluster ns <namespace> - set the namespace where the Kafka cluster is running
#   hubot kafka cluster name - ask the name of the Kafka cluster
#   hubot kafka cluster name <cluster> - set the name of the Kafka cluster
#   hubot kafka cluster bootstrap - ask the bootstrap address of the Kafka cluster
#   hubot kafka cluster bootstrap <bootstrap> - set the bootstrap address of the Kafka cluster
#   hubot kafka cluster openshift - ask the URL being used in OpenShift urls
#   hubot kafka cluster openshift <url> - set the URL to use in generated OpenShift links
#   hubot kafka grafana host - ask the URL for Grafana
#   hubot kafka grafana host <url> - set the URL to use for Grafana
#   hubot kafka grafana org - ask the org id for Grafana
#   hubot kafka grafana org <url> - set the org id to use for Grafana
#   hubot kafka grafana apikey - ask the API key for Grafana
#   hubot kafka grafana apikey <key> - set the API key for Grafana
#
# Author:
#   dalelane

Config = require "./config"


module.exports = (@robot) ->

    robot.respond /kafka\s*config\s*/i, (res) ->
        robot.logger.debug "kafka config"
        ns = Config.getNamespace(res)
        name = Config.getClusterName(res)
        bootstrap = Config.getBootstrap(res)
        osconsole = Config.getOpenShiftConsole(res)
        grafanahost = Config.getGrafanaHost(res)
        grafanaorg = Config.getGrafanaOrgId(res)
        grafanakey = Config.getGrafanaApiKey(res)
        reply = "Here is how I'm configured:\n"
        reply += " managing the `#{name}` Kafka cluster in the `#{ns}` namespace\n"
        reply += " connecting using the bootstrap address `#{bootstrap}`\n"
        reply += "\n"
        reply += " using OpenShift console at #{osconsole}\n"
        reply += "\n"
        reply += " and Grafana at #{grafanahost}"
        return res.reply reply

    robot.respond /kafka\s*cluster\s*ns\s*(.+)?/i, (res) ->
        robot.logger.debug "kafka cluster ns"
        namespace = res.match[1]
        if not namespace or namespace is ""
            return res.reply "I'm #{role} looking after our `#{Config.getClusterName(res)}` Kafka cluster in the `#{Config.getNamespace(res)}` namespace"
        Config.setNamespace res, namespace
        return res.reply "Okay, I'll start looking after our Kafka cluster in the `#{namespace}` namespace"

    robot.respond /kafka\s*cluster\s*name\s*(.+)?/i, (res) ->
        robot.logger.debug "kafka cluster name"
        cluster = res.match[1]
        if not cluster or cluster is ""
            return res.reply "I'm looking after our `#{Config.getClusterName(res)}` Kafka cluster in the `#{Config.getNamespace(res)}` namespace"
        Config.setClusterName res, cluster
        return res.reply "Okay, I'll start looking after our `#{cluster}` Kafka cluster"

    robot.respond /kafka\s*cluster\s*bootstrap\s*(.+)?/i, (res) ->
        robot.logger.debug "kafka cluster bootstrap"
        bootstrap = res.match[1]
        if not bootstrap or bootstrap is ""
            return res.reply "I'm using `#{Config.getBootstrap(res)}` to connect to the Kafka cluster"
        Config.setBootstrap res, bootstrap
        return res.reply "Okay, I'll use `#{bootstrap}` to connect to the Kafka cluster"

    robot.respond /kafka\s*cluster\s*openshift\s*(.+)?/i, (res) ->
        robot.logger.debug "kafka cluster openshift"
        openshift = res.match[1]
        if not openshift or openshift is ""
            return res.reply "I'm using the URL `#{Config.getOpenShiftConsole(res)}` when generating OpenShift Console links"
        Config.setOpenShiftConsole res, openshift
        return res.reply "Okay, I'll use `#{openshift}` when generating OpenShift Console links"

    robot.respond /kafka\s*grafana\s*host\s*(.+)?/i, (res) ->
        robot.logger.debug "kafka grafana host"
        host = res.match[1]
        if not host or host is ""
            return res.reply "I'm using `#{Config.getGrafanaHost(res)}` for Grafana visualisations"
        Config.setGrafanaHost res, host
        return res.reply "Okay, I'll use `#{host}` for Grafana visualisations"

    robot.respond /kafka\s*grafana\s*org\s*(.+)?/i, (res) ->
        robot.logger.debug "kafka grafana org"
        orgid = res.match[1]
        if not orgid or orgid is ""
            return res.reply "I'm using `#{Config.getGrafanaOrgId(res)}` for Grafana visualisations"
        Config.setGrafanaOrgId res, orgid
        return res.reply "Okay, I'll use the org id `#{orgid}` for Grafana visualisations"

    robot.respond /kafka\s*grafana\s*apikey\s*(.+)?/i, (res) ->
        robot.logger.debug "kafka grafana apikey"
        apikey = res.match[1]
        if not apikey or apikey is ""
            return res.reply "I'm using `#{Config.getGrafanaApiKey(res)}` for Grafana API calls"
        Config.setGrafanaApiKey res, apikey
        return res.reply "Okay, I'll use `#{apikey}` for Grafana API calls"
