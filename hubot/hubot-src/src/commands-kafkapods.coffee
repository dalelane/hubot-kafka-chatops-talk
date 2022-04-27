# Description:
#   Gets or modifies the status of Kafka and ZooKeeper pods
#
# Dependencies:
#   "moment": "2.29.2"
#
# Configuration:
#   HUBOT_KAFKA_K8S_NAMESPACE - default namespace where Kafka is running
#   HUBOT_KAFKA_CLUSTER_NAME - default name of the Kafka cluster to manage
#   HUBOT_KAFKA_OPENSHIFT_CONSOLE - default URL for the OpenShift Console
#
# Commands:
#   hubot kafka restart broker <number> - restarts a Kafka broker
#   hubot kafka status kafka - gets the status of the Kafka brokers
#   hubot kafka status zookeeper - gets the status of the ZooKeeper nodes
#   hubot kafka logs kafka <number> - gets the logs for a Kafka broker
#   hubot kafka events - get events from pods in the Kafka cluster
#   hubot kafka warnings - get warnings from pods in the Kafka cluster
#
# Author:
#   dalelane

moment = require "moment"

Config = require "./config"
KubeApi = require "./kubeapi"
Roles = require "./auth-roles"


module.exports = (@robot) ->

    kubeapi = new KubeApi()


    #
    #
    #

    robot.respond /kafka\s*(?:what is)?\s*(?:the)?\s*status\s*(?:of the)?\s*kafka\s*(?:brokers)?\s*/i, (res) ->
        robot.logger.debug "kafka status kafka"
        if !robot.auth.hasRole(res.envelope.user, Roles.READ_ONLY)
            return res.reply "Sorry! You can't ask me for the status of Kafka brokers."

        path = brokerPodsUrl res
        kubeapi.get { path }, (err, resp) ->
            if err
                robot.logger.error path
                robot.logger.error err
                return res.reply "Sorry! I couldn't get the Kafka brokers status"

            response = generatePodsList res, "Kafka brokers", resp.items
            return res.reply response


    #
    #
    #

    robot.respond /kafka\s*(?:what is)?\s*(?:the)?\s*status\s*(?:of the)?\s*zookeeper\s*(?:nodes)?\s*/i, (res) ->
        robot.logger.debug "kafka status zookeeper"
        if !robot.auth.hasRole(res.envelope.user, Roles.READ_ONLY)
            return res.reply "Sorry! You can't ask me for the status of ZooKeeper nodes."

        path = zookeeperPodsUrl res
        kubeapi.get { path }, (err, resp) ->
            if err
                robot.logger.error path
                robot.logger.error err
                return res.reply "Sorry! I couldn't get the ZooKeeper nodes status"

            response = generatePodsList res, "ZooKeeper nodes", resp.items
            return res.reply response


    #
    #
    #

    robot.respond /kafka\s*(?:get me|get|get me the|get the|fetch|fetch the)?\s*logs\s*(?:for|from|of)?\s*(?:kafka|broker)\s*([0-9])\s*/i, (res) ->
        robot.logger.debug "kafka logs broker"
        if !robot.auth.hasRole(res.envelope.user, Roles.READ_ONLY)
            return res.reply "Sorry! You can't ask me for Kafka broker logs."

        brokerIdx = res.match[1]
        path = brokerLogsUrl res, brokerIdx

        kubeapi.get { path }, (err, resp) ->
            if err
                robot.logger.error path
                robot.logger.error err
                return res.reply "Sorry! I couldn't get the Kafka broker logs"

            return res.reply "Sorry! Logs not found for broker #{brokerIdx}" unless resp

            opts =
                content : resp
                title : "logs for broker " + brokerIdx
                channels : res.envelope.room

            robot.adapter.client.web.files.upload("broker-" + brokerIdx + ".txt", opts)

    #
    #
    #

    robot.respond /kafka\s*(?:get me|get|get me the|get the|fetch|fetch the)?\s*(?:pod)?\s*events\s*/i, (res) ->
        robot.logger.debug "kafka events"
        if !robot.auth.hasRole(res.envelope.user, Roles.READ_ONLY)
            return res.reply "Sorry! You can't ask me for Kafka pod events."

        path = eventsUrl res

        kubeapi.get { path }, (err, resp) ->
            if err
                robot.logger.error path
                robot.logger.error err
                return res.reply "Sorry! I couldn't get events from Kafka pods"

            response = generateEventsList res, resp.items
            return res.reply response

    robot.respond /kafka\s*(?:get me|get|get me the|get the|fetch|fetch the)?\s*(?:pod)?\s*warnings\s*/i, (res) ->
        robot.logger.debug "kafka warnings"
        if !robot.auth.hasRole(res.envelope.user, Roles.READ_ONLY)
            return res.reply "Sorry! You can't ask me for Kafka pod events."

        path = eventsUrl res

        kubeapi.get { path }, (err, resp) ->
            if err
                robot.logger.error path
                robot.logger.error err
                return res.reply "Sorry! I couldn't get events from Kafka pods"

            warnings = resp.items.filter((itm) -> itm.type == "Warning")

            response = generateEventsList res, warnings
            return res.reply response

    #
    #
    #

    robot.respond /kafka\s*restart\s*broker\s*([0-9])\s*/i, (res) ->
        robot.logger.debug "kafka restart broker"
        if !robot.auth.hasRole(res.envelope.user, Roles.MODIFY)
            return res.reply "Sorry! You can't ask me to restart Kafka brokers."

        brokerIdx = res.match[1]
        path = brokerPodUrl res, brokerIdx

        kubeapi.del { path }, (err, resp) ->
            if err
                robot.logger.error path
                robot.logger.error err
                return res.reply "Sorry! I couldn't restart the Kafka broker"

            return res.reply "Okay, I've restarted broker `#{brokerIdx}`"


    #
    #
    #


    brokerPodsLabel = (res) ->
        return "strimzi.io/name=" + Config.getClusterName(res) + "-kafka"

    zookeeperPodsLabel = (res) ->
        return "strimzi.io/name=" + Config.getClusterName(res) + "-zookeeper"

    brokerPodsUrl = (res) ->
        labelSelector = brokerPodsLabel res
        namespace = Config.getNamespace(res)
        return "/api/v1/namespaces/#{namespace}/pods?labelSelector=#{labelSelector}"

    zookeeperPodsUrl = (res) ->
        labelSelector = zookeeperPodsLabel res
        namespace = Config.getNamespace(res)
        return "/api/v1/namespaces/#{namespace}/pods?labelSelector=#{labelSelector}"

    #

    brokerPodName = (res, idx) ->
        return Config.getClusterName(res) + '-kafka-' + idx

    brokerPodUrl = (res, idx) ->
        resource = brokerPodName res, idx
        namespace = Config.getNamespace(res)
        return "/api/v1/namespaces/#{namespace}/pods/#{resource}"

    brokerLogsUrl = (res, idx) ->
        podUrl = brokerPodUrl res, idx
        return "#{podUrl}/log"

    #

    eventsUrl = (res) ->
        namespace = Config.getNamespace(res)
        return "/api/v1/namespaces/#{namespace}/events"

    #

    generatePodsList = (res, title, items) ->
        dashboardPrefix = Config.getOpenShiftConsole(res)

        reply = "Here are the list of #{title}:\n"
        for pod in items
            {metadata: {name, namespace}, status: {phase, startTime, containerStatuses}} = pod
            podRestartCount = 0
            podReadyCount = 0
            podCount = 0
            for cs in containerStatuses
                {restartCount, ready, image} = cs
                podRestartCount = podRestartCount + restartCount
                podCount = podCount + 1
            if ready then podReadyCount = podReadyCount + 1
            reply += ">*<#{dashboardPrefix}/k8s/ns/#{namespace}/pods/#{name}|#{name}>* - "
            reply += "pods `#{podReadyCount}/#{podCount}` with status `#{phase}` and restart count `#{restartCount}` since `#{moment(startTime).fromNow()}`\n"

        return reply


    generateEventsList = (res, items) ->
        if !items or items.length == 0
            return "There are no events from pods in the Kafka cluster"

        dashboardPrefix = Config.getOpenShiftConsole(res)

        reply = "Here are the list of events from pods in the Kafka cluster:\n"
        items.reverse()
        for event in items
            {involvedObject: {name, kind, namespace}, reason, message, firstTimestamp, lastTimestamp, count, type} = event
            kind = kind.toLowerCase() + 's'
            reply += "*<#{dashboardPrefix}/k8s/ns/#{namespace}/#{kind}/#{name}/events|#{name}> - "
            reply += "`#{type}` event - #{moment(lastTimestamp).fromNow()}*\n"
            reply += "> #{reason}\n" if reason
            reply += "> #{message}\n"

        return reply
