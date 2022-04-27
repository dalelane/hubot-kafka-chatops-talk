#!/bin/sh

echo "-------------------"
echo "creating namespaces"
echo "-------------------"

kubectl create namespace kafka-ns      --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace prometheus-ns --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace grafana-ns    --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace hubot-ns      --dry-run=client -o yaml | kubectl apply -f -

echo "> namespaces ready"
