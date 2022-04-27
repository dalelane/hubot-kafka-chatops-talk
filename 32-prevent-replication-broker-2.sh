#!/bin/sh

echo "----------------------------------------------------------------------------"
echo "Simulating network infrastructure problem that prevents broker 2 replicating"
echo "----------------------------------------------------------------------------"

kubectl apply -f ./network-policies/prevent-replication-broker-2
kubectl delete pods -n kafka-ns my-kafka-cluster-kafka-2 &

echo "> Kafka broker 2 cannot replicate"
