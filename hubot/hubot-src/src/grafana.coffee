request = require "request"

Config = require "./config"



class Grafana

    constructor: () ->
        @visualisations =
            memory:
                title: 'Memory usage by the Kafka brokers'
                dashboard: '86cc98e66c294b299b37102f0cc74ead'
                panel: 10
            cpu:
                title: 'CPU usage by the Kafka brokers'
                dashboard: '86cc98e66c294b299b37102f0cc74ead'
                panel: 11
            disk:
                title: 'Disk space available to Kafka brokers'
                dashboard: '86cc98e66c294b299b37102f0cc74ead'
                panel: 12
            network:
                title: 'Network usage by Kafka brokers in bytes per second'
                dashboard: '86cc98e66c294b299b37102f0cc74ead'
                panel: 22
            messagesin:
                title: 'Number of Kafka messages (in) per second'
                dashboard: '86cc98e66c294b299b37102f0cc74ead'
                panel: 23


    getVisualisation: (res, name, hours, callback) ->
        visualisation = @visualisations[name]
        @getVisualisationId res, visualisation, (err, dashboarduid, panelid) =>
            return callback(err) if err

            visualisationurl = @getGrafanaVisualisationUrl res, dashboarduid, panelid, hours

            requestOptions = @defaultRequestOptions res, visualisationurl
            requestOptions.encoding = null
            requestOptions.headers.Accept = "image/png"
            request.get requestOptions, (vizerr, resp, data) =>
                callback vizerr, visualisation, data, resp.headers['content-length']


    #
    #
    #


    defaultRequestOptions: (res, url) ->
        options =
            url : url
            headers :
                Accept : "application/json"
            auth :
                bearer : Config.getGrafanaApiKey(res)
        return options



    getVisualisationId: (res, visualisation, callback) ->
        url = @getGrafanaDashboardUrl res, visualisation.dashboard
        requestOptions = @defaultRequestOptions res, url

        request.get requestOptions, (err, resp, data) ->
            return callback(err) if err
            dashboardInfo = JSON.parse(data)

            visualisation.dashboardUrl = process.env.HUBOT_GRAFANA_HOST + dashboardInfo.meta.url

            data = dashboardInfo.dashboard
            if data.panels
                data.rows = [ dashboardInfo.dashboard ]

            panelNumber = 0
            for row in data.rows
                for panel in row.panels
                    panelNumber += 1

                    if visualisation.panel == panelNumber
                        return callback null, dashboardInfo.dashboard.uid, panel.id

            return callback new Error("Could not find visualisation")


    #
    #
    #


    getGrafanaDashboardUrl: (res, uid) ->
        host = Config.getGrafanaHost(res)
        return "#{host}/api/dashboards/uid/#{uid}"

    getGrafanaVisualisationUrl: (res, dashboarduid, panelid, hours) ->
        host = Config.getGrafanaHost(res)

        starttime = if hours then (hours + "h") else "1h"
        timespanfrom = "now-" + starttime

        width = process.env.HUBOT_GRAFANA_DEFAULT_WIDTH or 1000
        height = process.env.HUBOT_GRAFANA_DEFAULT_HEIGHT or 500
        orgId = Config.getGrafanaOrgId(res)

        imageUrl = "#{host}/render/d-solo/#{dashboarduid}/?"
        imageUrl += "panelId=#{panelid}&"
        imageUrl += "width=#{width}&height=#{height}&"
        imageUrl += "from=#{timespanfrom}&to=now&"
        imageUrl += "orgId=#{orgId}&"
        imageUrl += "theme=light"

        return imageUrl



module.exports = Grafana
