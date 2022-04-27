#!/bin/sh

echo "-----------------------------"
echo "Creating the Grafana instance"
echo "-----------------------------"

kubectl apply -f ./grafana-server/grafana-rendering-deployment.yaml
kubectl apply -f ./grafana-server/grafana-rendering-service.yaml
kubectl apply -f ./grafana-server/grafana-rendering-secret.yaml

kubectl apply -f ./grafana-server/grafana.yaml
kubectl apply -f ./grafana-server/prometheus-datasource.yaml

echo "> Grafana is ready"
