#!/bin/sh

echo "-----------------------"
echo "Deleting the demo topic"
echo "-----------------------"

echo "Deleting topic"
kubectl delete -f ./kafka-topics/demo-topic.yaml
