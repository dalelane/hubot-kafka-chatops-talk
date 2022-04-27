# Description:
#     Move topic partitions to different Kafka brokers
#
# Configuration:
#   HUBOT_KAFKA_K8S_NAMESPACE - default namespace where Kafka is running
#   HUBOT_KAFKA_CLUSTER_NAME - default name of the Kafka cluster to manage
#
# Commands:
#   hubot kafka move <topicname> to broker <brokernum> - move a single-partition, 1-replica topic to a different broker
#   hubot kafka move partition <partitionnum> of <topicname> to broker <brokernum> - move a specific partition of a 1-replica topic to a different broker
#   hubot kafka move partition <partitionnum> of <topicname> to broker <brokernum> with replicas on broker <brokernum> and broker <brokernum> - move a specific partition of a topic and its replicas
#
# Notes:
#   Requires kubectl to be available and configured
#
# Author:
#   dalelane

Roles = require "./auth-roles"
KafkaTopicReassigner = require "./kafkatopicreassignment"


module.exports = (@robot) ->

    topicReassigner = new KafkaTopicReassigner()

    robot.respond /kafka\s*move\s*(?:partition\s*([0-9])\s*of\s*)?\s*(?:topic)?\s*([A-Za-z._]+)\s*to\s*(?:broker)?\s*([0-9])\s*(?:with)?\s*(?:replicas\s*on\s*)?(?:(?:broker)?\s*([0-9])\s*(?:and)*\s*)?(?:(?:broker)?\s*([0-9])\s*(?:and)*\s*)?(?:(?:broker)?\s*([0-9])\s*(?:and)*\s*)?/i, (res) ->
        robot.logger.debug "kafka move topic"
        if !robot.auth.hasRole(res.envelope.user, Roles.MODIFY)
            return res.reply "Sorry! You can't ask me to move Kafka topics."

        # partition index (assume 0 if not specified)
        partitionStr = res.match[1]
        if partitionStr and partitionStr != ""
            partitionToMove = parseInt(partitionStr, 10)
        else
            partitionToMove = 0

        # topic name
        topicToMove = res.match[2]

        # replicas
        targetLeaderBrokerIdx = res.match[3]
        replicas = [ parseInt(targetLeaderBrokerIdx, 10) ]
        log_dirs = [ "any" ]
        for i in [4..6]
            if res.match[i] and res.match[i] != ""
                replicas.push parseInt(res.match[i], 10)
                log_dirs.push "any"

        # assemble the final request
        moveSpec =
            topic : topicToMove
            partition : partitionToMove
            replicas : replicas
            log_dirs : log_dirs
        request =
            version : 1
            partitions : [ moveSpec ]

        topicReassigner.moveTopic res, request, (err, stdout, stderr) ->
            if err
                robot.logger.error err
                return res.reply "Sorry, I couldn't move the topic!"
            robot.logger.info stdout
            robot.logger.error stderr
            res.reply "Okay... I've submitted a request to move #{topicToMove}"

