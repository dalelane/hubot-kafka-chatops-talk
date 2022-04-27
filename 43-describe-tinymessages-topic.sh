#!/bin/sh

echo "------------------------"
echo "Describing TINY.MESSAGES"
echo "------------------------"

kubectl exec my-kafka-cluster-kafka-0 -n kafka-ns -it -- /opt/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic TINY.MESSAGES
