fs = require "fs"
request = require "request"


class KubeApi
    constructor: () ->
        @urlPrefix = "https://kubernetes.default:443"
        @k8sCA = fs.readFileSync("/var/run/secrets/kubernetes.io/serviceaccount/ca.crt")
        @k8sToken = fs.readFileSync("/var/run/secrets/kubernetes.io/serviceaccount/token")


    defaultRequestOptions: (path) ->
        options =
            url : @urlPrefix + path
            agentOptions :
                ca : @k8sCA
            auth :
                bearer : @k8sToken
        return options



    get: ({ path }, callback) ->
        requestOptions = @defaultRequestOptions path

        request.get requestOptions, (err, resp, data) ->
            return callback(err) if err
            if resp.statusCode == 404
                return callback null, null
            if resp.statusCode != 200
                return callback new Error("Something went wrong! HTTP-#{resp.statusCode} #{data}")
            if data.startsWith "{"
                return callback null, JSON.parse(data)
            else
                return callback null, data




    del: ({ path }, callback) ->
        requestOptions = @defaultRequestOptions path

        request.del requestOptions, (err, resp, data) ->
            return callback(err) if err
            if resp.statusCode == 404
                return callback null, null
            if resp.statusCode != 200 && resp.statusCode != 202
                return callback new Error("Something went wrong! HTTP-#{resp.statusCode} #{data}")
            if data.startsWith "{"
                return callback null, JSON.parse(data)
            else
                return callback null, data




    patch: ({ path, value }, callback) ->
        requestOptions = @defaultRequestOptions path

        requestOptions.body = JSON.stringify value
        requestOptions.headers = {
            "Content-Type" : "application/merge-patch+json"
        }

        request.patch requestOptions, (err, resp, data) ->
            return callback(err) if err
            if resp.statusCode == 404
                return callback new Error("Sorry! I couldn't find the Kafka cluster!")
            if resp.statusCode >= 400
                return callback new Error("Sorry! I couldn't modify the Kafka cluster!")
            if data.startsWith "{"
                return callback null, JSON.parse(data)
            else
                return callback null, data



module.exports = KubeApi
