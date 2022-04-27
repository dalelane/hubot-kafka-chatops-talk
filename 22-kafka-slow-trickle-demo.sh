#!/bin/sh

echo "---------------------------------------------------------"
echo "Creating a two-replica topic and producing messages to it"
echo "---------------------------------------------------------"

echo "Creating topic"
kubectl apply -f ./kafka-topics/demo-topic.yaml
kubectl wait --for=condition=ready --timeout=1m kafkatopic demo.topic -n kafka-ns
sleep 1

echo "Identifying which broker has the topic leader"
cat >/tmp/get-broker-num.sh <<EOL
/opt/kafka/bin/kafka-topics.sh  --bootstrap-server localhost:9092  --topic DEMO.TOPIC  --describe | grep -oP '(?<=Leader: )[0-9]'
EOL
kubectl cp -n kafka-ns /tmp/get-broker-num.sh my-kafka-cluster-kafka-0:/tmp
kubectl exec my-kafka-cluster-kafka-0 -n kafka-ns -it -- chmod +x /tmp/get-broker-num.sh
BROKER_NUM=$(kubectl exec my-kafka-cluster-kafka-0 -n kafka-ns -it -- sh -c "echo -n \$(/tmp/get-broker-num.sh)" | tr -d '\n')
echo ""

echo "The DEMO.TOPIC topic leader is on broker $BROKER_NUM"
echo ""

echo "Producing messages to DEMO.TOPIC (approx one message per second)"
kubectl exec my-kafka-cluster-kafka-$BROKER_NUM -n kafka-ns -it -- /opt/kafka/bin/kafka-producer-perf-test.sh --producer.config /opt/kafka/config/producer.properties  --print-metrics  --topic DEMO.TOPIC --record-size 1000 --num-records 1000000000 --throughput 1

echo "> Demo topic complete"
