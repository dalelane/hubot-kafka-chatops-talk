class Config

    #
    # Kubernetes namespace where the Kafka cluster (that
    #  Hubot is managing) is running
    #

    @defaultNamespace = process.env.HUBOT_KAFKA_K8S_NAMESPACE

    @getNamespace = (res) ->
        user = res.message.user.id
        key = "#{user}.kafka.namespace"
        return robot.brain.get(key) or @defaultNamespace

    @setNamespace = (res, namespace) ->
        user = res.message.user.id
        key = "#{user}.kafka.namespace"
        return robot.brain.set(key, namespace or @defaultNamespace)


    #
    # Name of the (Strimzi) Kafka cluster that Hubot
    #  is managing
    #

    @defaultClusterName = process.env.HUBOT_KAFKA_CLUSTER_NAME

    @getClusterName = (res) ->
        user = res.message.user.id
        key = "#{user}.kafka.cluster"
        return robot.brain.get(key) or @defaultClusterName

    @setClusterName = (res, clustername) ->
        user = res.message.user.id
        key = "#{user}.kafka.cluster"
        return robot.brain.set(key, clustername or @defaultClusterName)


    #
    # Bootstrap address for connecting Kafka clients
    #  to the cluster that Hubot is managing
    #

    @defaultBootstrap = process.env.HUBOT_KAFKA_BOOTSTRAP

    @getBootstrap = (res) ->
        user = res.message.user.id
        key = "#{user}.kafka.bootstrap"
        return robot.brain.get(key) or @defaultBootstrap

    @setBootstrap = (res, bootstrap) ->
        user = res.message.user.id
        key = "#{user}.kafka.bootstrap"
        return robot.brain.set(key, bootstrap or @defaultBootstrap)


    #
    # URL for the OpenShift cluster where Kafka is running
    #

    @defaultConsoleUrl = process.env.HUBOT_KAFKA_OPENSHIFT_CONSOLE

    @getOpenShiftConsole = (res) ->
        user = res.message.user.id
        key = "#{user}.kafka.openshiftconsole"
        return robot.brain.get(key) or @defaultConsoleUrl

    @setOpenShiftConsole = (res, openshiftconsole) ->
        user = res.message.user.id
        key = "#{user}.kafka.openshiftconsole"
        return robot.brain.set(key, openshiftconsole or @defaultConsoleUrl)


    #
    # URL for the Grafana API
    #

    @defaultGrafanaHost = process.env.HUBOT_GRAFANA_HOST

    @getGrafanaHost = (res) ->
        user = res.message.user.id
        key = "#{user}.kafka.grafanahost"
        return robot.brain.get(key) or @defaultGrafanaHost

    @setGrafanaHost = (res, host) ->
        user = res.message.user.id
        key = "#{user}.kafka.grafanahost"
        return robot.brain.set(key, host or @defaultGrafanaHost)


    #
    # Grafana organisation id
    #

    @defaultGrafanaOrgId = process.env.HUBOT_GRAFANA_ORG_ID

    @getGrafanaOrgId = (res) ->
        user = res.message.user.id
        key = "#{user}.kafka.grafanaorgid"
        return robot.brain.get(key) or @defaultGrafanaOrgId

    @setGrafanaOrgId = (res, orgid) ->
        user = res.message.user.id
        key = "#{user}.kafka.grafanaorgid"
        return robot.brain.set(key, orgid or @defaultGrafanaOrgId)


    #
    # API key for Grafana API calls
    #

    @defaultGrafanaApiKey = process.env.HUBOT_GRAFANA_API_KEY

    @getGrafanaApiKey = (res) ->
        user = res.message.user.id
        key = "#{user}.kafka.grafanaapikey"
        return robot.brain.get(key) or @defaultGrafanaApiKey

    @setGrafanaApiKey = (res, apikey) ->
        user = res.message.user.id
        key = "#{user}.kafka.grafanaapikey"
        return robot.brain.set(key, apikey or @defaultGrafanaApiKey)



module.exports = Config
