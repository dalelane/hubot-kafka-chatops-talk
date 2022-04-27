#!/bin/sh

echo "----------------------------"
echo "Simulate a crash of broker 0"
echo "----------------------------"

kubectl exec my-kafka-cluster-kafka-0 -n kafka-ns -it -- /bin/sh -c "kill 1"

echo "> Broker 0 crashing"
