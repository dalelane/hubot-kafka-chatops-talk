#!/bin/sh

echo "----------------------"
echo "Keep crashing broker 1"
echo "----------------------"

while true
do
    # wait for it to come back
    kubectl wait --for=condition=ready pod my-kafka-cluster-kafka-1  -nkafka-ns
    # crash it again
    kubectl exec my-kafka-cluster-kafka-1 -n kafka-ns -it -- /bin/sh -c "kill 1"
done
