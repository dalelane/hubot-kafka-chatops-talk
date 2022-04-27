#!/bin/sh

echo "---------------------------------------------------------"
echo "Creating a topic and slowly producing tiny messages to it"
echo "---------------------------------------------------------"

echo "Creating topic"
kubectl apply -f ./kafka-topics/tiny-messages.yaml
kubectl wait --for=condition=ready --timeout=1m kafkatopic tiny.messages -n kafka-ns
sleep 1

echo "Identifying which broker has the topic leader"
cat >/tmp/get-broker-num.sh <<EOL
/opt/kafka/bin/kafka-topics.sh  --bootstrap-server localhost:9092  --topic TINY.MESSAGES  --describe | grep -oP '(?<=Leader: )[0-9]'
EOL
kubectl cp -n kafka-ns /tmp/get-broker-num.sh my-kafka-cluster-kafka-0:/tmp
kubectl exec my-kafka-cluster-kafka-0 -n kafka-ns -it -- chmod +x /tmp/get-broker-num.sh
BROKER_NUM=$(kubectl exec my-kafka-cluster-kafka-0 -n kafka-ns -it -- sh -c "echo -n \$(/tmp/get-broker-num.sh)" | tr -d '\n')
echo ""

echo "The TINY.MESSAGES topic leader is on broker $BROKER_NUM"
echo ""

echo "Sending 'hi' to TINY.MESSAGES every 5 seconds"
while true
do
    kubectl exec my-kafka-cluster-kafka-$BROKER_NUM -n kafka-ns -it -- /bin/sh -c "echo hi | /opt/kafka/bin/kafka-console-producer.sh --topic TINY.MESSAGES  --bootstrap-server localhost:9092"
    echo "$(date) hi"
    sleep 5
done
