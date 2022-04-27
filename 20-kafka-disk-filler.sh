#!/bin/sh

echo "------------------------------------------------------------------------"
echo "Creating a topic on a single broker and producing 19GB of messages to it"
echo "------------------------------------------------------------------------"

echo "Creating topic"
kubectl apply -f ./kafka-topics/disk-filler.yaml
kubectl wait --for=condition=ready --timeout=1m kafkatopic disk.filler -n kafka-ns

echo "Identifying which broker has the topic"
cat >/tmp/get-broker-num.sh <<EOL
/opt/kafka/bin/kafka-topics.sh  --bootstrap-server localhost:9092  --topic DISK.FILLER  --describe | grep -oP '(?<=Leader: )[0-9]'
EOL
kubectl cp -n kafka-ns /tmp/get-broker-num.sh my-kafka-cluster-kafka-0:/tmp
kubectl exec my-kafka-cluster-kafka-0 -n kafka-ns -it -- chmod +x /tmp/get-broker-num.sh
BROKER_NUM=$(kubectl exec my-kafka-cluster-kafka-0 -n kafka-ns -it -- sh -c "echo -n \$(/tmp/get-broker-num.sh)" | tr -d '\n')
echo ""

echo "The DISK.FILLER topic is on broker $BROKER_NUM"
echo ""

echo "Generating approx 19gb of data on broker $BROKER_NUM"
kubectl exec my-kafka-cluster-kafka-$BROKER_NUM -n kafka-ns -it -- /opt/kafka/bin/kafka-producer-perf-test.sh --producer.config /opt/kafka/config/producer.properties  --print-metrics  --topic DISK.FILLER --record-size 1000000 --num-records 19000 --throughput -1

echo "> Disk filler topic complete"
