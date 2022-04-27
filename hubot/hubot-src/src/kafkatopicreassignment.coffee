fs = require "fs"
path = require "path"
os = require "os"
crypto = require "crypto"
child_process = require "child_process"

Config = require "./config"


class KafkaTopicReassigner

    constructor: () ->
        #


    generateFilename: () ->
        return "topics-" + crypto.randomBytes(8).toString("hex") + ".json"

    moveTopic: (res, moveRequest, callback) ->
        @writeToFile moveRequest, (err, requestFile) =>
            return callback(err) if err
            targetFile = "/tmp/" + @generateFilename()

            copyCommand = "kubectl cp " + requestFile + " " + @ns(res) + "/" + @podName(res) + ":" + targetFile
            child_process.exec copyCommand, (cperr, cpstdout, cpstderr) =>
                return callback(cperr) if cperr

                executeCommand = "kubectl exec " + @podName(res) + " -c kafka -n " + @ns(res) + " -it -- " +
                    "/opt/kafka/bin/kafka-reassign-partitions.sh " +
                    "--bootstrap-server localhost:9092 " +
                    "--reassignment-json-file " + targetFile + " " +
                    "--execute --additional"
                child_process.exec executeCommand, (exeerr, exestdout, exestderr) ->
                    callback exeerr, cpstdout + "\n" + exestdout, cpstderr + "\n" + exestderr


    ns: (res) ->
        return Config.getNamespace(res)
    instance: (res) ->
        return Config.getClusterName(res)
    podName: (res) ->
        return @instance(res) + "-kafka-0"

    getTempFilePath: () ->
        filename = "topics-" + crypto.randomBytes(8).toString("hex") + ".json"
        return path.join os.tmpdir(), @generateFilename()

    writeToFile: (obj, callback) ->
        loc = @getTempFilePath()
        data = JSON.stringify obj
        fs.writeFile loc, data, (err) ->
            callback err, loc




module.exports = KafkaTopicReassigner
