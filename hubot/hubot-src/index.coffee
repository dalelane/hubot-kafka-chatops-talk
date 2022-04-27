path = require 'path'

module.exports = (robot) ->
    scriptsPath = path.resolve(__dirname, 'src')
    robot.loadFile(scriptsPath, 'commands-config.coffee')
    robot.loadFile(scriptsPath, 'commands-kafkaconfig.coffee')
    robot.loadFile(scriptsPath, 'commands-kafkapods.coffee')
    robot.loadFile(scriptsPath, 'commands-kafkatopics.coffee')
    robot.loadFile(scriptsPath, 'commands-visualisations.coffee')
    robot.loadFile(scriptsPath, 'commands-kafkamover.coffee')
