#!/bin/sh

echo "-------------------------"
echo "Creating the Kafka canary"
echo "-------------------------"

kubectl apply -f ./kafka-canary/serviceaccount.yaml
kubectl apply -f ./kafka-canary/deployment.yaml
kubectl apply -f ./kafka-canary/service.yaml

echo "> Kafka canary is running"
