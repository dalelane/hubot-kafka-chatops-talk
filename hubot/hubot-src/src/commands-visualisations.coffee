# Description:
#     Get visualisations showing what is happening in the Kafka cluster from Grafana
#
# Configuration:
#   HUBOT_GRAFANA_HOST - URL for Grafana
#   HUBOT_GRAFANA_ORG_ID - org ID for Grafana API calls
#   HUBOT_GRAFANA_API_KEY - API key for querying Grafana
#   HUBOT_GRAFANA_DEFAULT_WIDTH - width for visualisations
#   HUBOT_GRAFANA_DEFAULT_HEIGHT - height for visualisations
#
# Commands:
#   hubot kafka show me memory - show the memory usage of the Kafka brokers
#   hubot kafka show me cpu - show the CPU usage of the Kafka brokers
#   hubot kafka show me disk - show the disk space available to Kafka brokers
#   hubot kafka show me network - show the network usage by Kafka brokers
#   hubot kafka show me messagesin - show the number of Kafka messages per second
#
# Author:
#   dalelane

Grafana = require "./grafana"
Roles = require "./auth-roles"


module.exports = (@robot) ->

    grafana = new Grafana()

    robot.respond /kafka\s*show\s*me\s*(memory|cpu|disk|network|messagesin)\s*(?:for the last ([0-9]+) hours)?\s*/i, (res) ->
        robot.logger.debug "kafka show me visualisations"
        if !robot.auth.hasRole(res.envelope.user, Roles.READ_ONLY)
            return res.reply "Sorry! You can't ask me for Kafka cluster visualisations."

        requested = res.match[1]
        timeSpanHours = res.match[2]

        grafana.getVisualisation res, requested, timeSpanHours, (err, visualisationInfo, visualisationImage, imageSize) ->
            if err
                robot.logger.error err
                return res.reply "Sorry! I couldn't get the visualisation"

            file =
                value : visualisationImage
                options :
                    filename : requested + ".png"
                    contentType : "image/png"
                    knownLength : imageSize

            opts =
                file : file
                filetype : "png"
                title : visualisationInfo.title
                channels : res.envelope.room
                initial_comment : "I got this from <" + visualisationInfo.dashboardUrl + "|this Grafana dashboard>"

            robot.adapter.client.web.files.upload(requested + ".png", opts)
