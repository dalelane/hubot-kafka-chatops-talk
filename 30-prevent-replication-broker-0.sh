#!/bin/sh

echo "----------------------------------------------------------------------------"
echo "Simulating network infrastructure problem that prevents broker 0 replicating"
echo "----------------------------------------------------------------------------"

kubectl apply -f ./network-policies/prevent-replication-broker-0
kubectl delete pods -n kafka-ns my-kafka-cluster-kafka-0 &

echo "> Kafka broker 0 cannot replicate"
