#!/bin/sh

echo "----------------------------------------------------------------------------"
echo "Simulating network infrastructure problem that prevents broker 3 replicating"
echo "----------------------------------------------------------------------------"

kubectl apply -f ./network-policies/prevent-replication-broker-3
kubectl delete pods -n kafka-ns my-kafka-cluster-kafka-3 &

echo "> Kafka broker 3 cannot replicate"
