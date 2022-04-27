#!/bin/sh

echo "-------------------"
echo "Deleting all topics"
echo "-------------------"

kubectl delete -f ./kafka-topics
