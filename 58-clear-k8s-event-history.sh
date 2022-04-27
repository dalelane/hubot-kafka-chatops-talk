#!/bin/sh

echo "------------------------------"
echo "Clearing events history in k8s"
echo "------------------------------"

kubectl delete `kubectl get events -nkafka-ns -o name` -nkafka-ns

echo "> Events history cleared"
