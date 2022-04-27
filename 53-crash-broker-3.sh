#!/bin/sh

echo "----------------------------"
echo "Simulate a crash of broker 3"
echo "----------------------------"

kubectl exec my-kafka-cluster-kafka-3 -n kafka-ns -it -- /bin/sh -c "kill 1"

echo "> Broker 3 crashing"
