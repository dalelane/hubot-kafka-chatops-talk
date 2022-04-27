#!/bin/sh

echo "--------------------------"
echo "Creating the Kafka cluster"
echo "--------------------------"

# setup network policies that will allow components to access the Kafka cluster
kubectl apply -f ./network-policies/allow-regular-traffic

# configure the metrics to collect from the cluster
kubectl apply -f ./kafka-cluster/metrics-configmap.yaml

# create the Kafka cluster
kubectl apply -f ./kafka-cluster/kafka.yaml

# wait for it to start
kubectl wait --for=condition=ready --timeout=40m kafka -n kafka-ns my-kafka-cluster

echo "> Kafka cluster is ready"
