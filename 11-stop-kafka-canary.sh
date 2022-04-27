#!/bin/sh

echo "-------------------------"
echo "Stopping the Kafka canary"
echo "-------------------------"

kubectl delete -f ./kafka-canary/deployment.yaml

echo "> Kafka canary is stopped"
