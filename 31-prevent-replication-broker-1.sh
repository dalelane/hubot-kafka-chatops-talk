#!/bin/sh

echo "----------------------------------------------------------------------------"
echo "Simulating network infrastructure problem that prevents broker 1 replicating"
echo "----------------------------------------------------------------------------"

kubectl apply -f ./network-policies/prevent-replication-broker-1
kubectl delete pods -n kafka-ns my-kafka-cluster-kafka-1 &

echo "> Kafka broker 1 cannot replicate"
