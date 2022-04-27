#!/bin/sh

echo "--------------------------------"
echo "Creating the Prometheus instance"
echo "--------------------------------"

echo "Setting up AlertManager"
kubectl apply -f ./prometheus-server/alertmanager.yaml
kubectl apply -f ./prometheus-server/alertmanager-route.yaml
kubectl apply -f ./prometheus-server/alertmanager-slack-apikey.yaml
kubectl apply -f ./prometheus-server/alertmanager-slack.yaml

echo "Setting up Prometheus"
kubectl apply -f ./prometheus-server/prometheus-rules.yaml
kubectl apply -f ./prometheus-server/prometheus-clusterrole.yaml
kubectl apply -f ./prometheus-server/prometheus-serviceaccount.yaml
kubectl apply -f ./prometheus-server/prometheus-clusterrolebinding.yaml
kubectl apply -f ./prometheus-server/prometheus-scrape-config.yaml
kubectl apply -f ./prometheus-server/monitor-pod-strimziclusteroperator.yaml
kubectl apply -f ./prometheus-server/monitor-pod-strimzientityoperator.yaml
kubectl apply -f ./prometheus-server/monitor-pod-kafka.yaml
kubectl apply -f ./prometheus-server/prometheus.yaml
kubectl apply -f ./prometheus-server/prometheus-route.yaml

echo "> Prometheus is ready"
