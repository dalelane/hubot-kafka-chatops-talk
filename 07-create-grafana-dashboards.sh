#!/bin/sh

echo "-------------------------------"
echo "Creating the Grafana dashboards"
echo "-------------------------------"

kubectl apply -f ./grafana-dashboards/strimzi-operators.yaml
kubectl apply -f ./grafana-dashboards/kafka.yaml
kubectl apply -f ./grafana-dashboards/zookeeper.yaml

echo "> Grafana dashboards are ready"
