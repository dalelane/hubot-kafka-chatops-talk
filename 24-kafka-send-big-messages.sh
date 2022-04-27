#!/bin/sh

echo "---------------------------------------------------"
echo "Creating a topic and producing large messages to it"
echo "---------------------------------------------------"

echo "Creating topic"
kubectl apply -f ./kafka-topics/large-messages.yaml
kubectl wait --for=condition=ready --timeout=1m kafkatopic large.messages -n kafka-ns
sleep 1

echo "Identifying which broker has the topic leader"
cat >/tmp/get-broker-num.sh <<EOL
/opt/kafka/bin/kafka-topics.sh  --bootstrap-server localhost:9092  --topic LARGE.MESSAGES  --describe | grep -oP '(?<=Leader: )[0-9]'
EOL
kubectl cp -n kafka-ns /tmp/get-broker-num.sh my-kafka-cluster-kafka-0:/tmp
kubectl exec my-kafka-cluster-kafka-0 -n kafka-ns -it -- chmod +x /tmp/get-broker-num.sh
BROKER_NUM=$(kubectl exec my-kafka-cluster-kafka-0 -n kafka-ns -it -- sh -c "echo -n \$(/tmp/get-broker-num.sh)" | tr -d '\n')
echo ""

echo "The LARGE.MESSAGES topic leader is on broker $BROKER_NUM"
echo ""

echo "Producing 2mb messages to LARGE.MESSAGES (approx one message per second)"
kubectl exec my-kafka-cluster-kafka-$BROKER_NUM -n kafka-ns -it -- /opt/kafka/bin/kafka-producer-perf-test.sh --producer.config /opt/kafka/config/producer.properties --producer-props max.request.size=2080000 --print-metrics  --topic LARGE.MESSAGES --record-size 2000000 --num-records 100000000 --throughput 1

echo "> large messages demo complete"
