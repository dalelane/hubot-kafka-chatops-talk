#!/bin/sh

echo "---------------------------------"
echo "Deleting the large messages topic"
echo "---------------------------------"

echo "Deleting topic"
kubectl delete -f ./kafka-topics/large-messages.yaml
