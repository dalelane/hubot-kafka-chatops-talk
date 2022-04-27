#!/bin/sh

echo "----------------------------"
echo "Simulate a crash of broker 1"
echo "----------------------------"

kubectl exec my-kafka-cluster-kafka-1 -n kafka-ns -it -- /bin/sh -c "kill 1"

echo "> Broker 1 crashing"
