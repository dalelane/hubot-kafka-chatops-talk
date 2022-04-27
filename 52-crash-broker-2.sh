#!/bin/sh

echo "----------------------------"
echo "Simulate a crash of broker 2"
echo "----------------------------"

kubectl exec my-kafka-cluster-kafka-2 -n kafka-ns -it -- /bin/sh -c "kill 1"

echo "> Broker 2 crashing"
