#!/bin/sh

echo "-------------------------------------------------"
echo "Deleting the topic used to fill broker disk space"
echo "-------------------------------------------------"

echo "Deleting topic"
kubectl delete -f ./kafka-topics/disk-filler.yaml
