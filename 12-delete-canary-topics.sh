#!/bin/sh

echo "---------------------------------------------"
echo "Deleting the topic used by the Strimzi canary"
echo "---------------------------------------------"

echo "Deleting topic"
kubectl delete -nkafka-ns `kubectl get kafkatopic -nkafka-ns -o name | grep "strimzi-canary"`
