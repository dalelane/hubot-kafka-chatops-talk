#!/bin/sh

echo "-----------"
echo "List topics"
echo "-----------"

# echo "topics known to the Kafka cluster"
kubectl exec my-kafka-cluster-kafka-0 -n kafka-ns -it -- /opt/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
# echo ""
# echo "topics known to the Kubernetes Operator"
# kubectl get kt -n kafka-ns -o jsonpath='{range .items[*]}{.spec.topicName}  ({.metadata.name}){"\n"}{end}'
