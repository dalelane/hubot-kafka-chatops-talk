#!/bin/sh

echo "--------------------------------"
echo "Deleting the tiny messages topic"
echo "--------------------------------"

echo "Deleting topic"
kubectl delete -f ./kafka-topics/tiny-messages.yaml
