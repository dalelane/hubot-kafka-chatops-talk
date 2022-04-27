#!/bin/sh

echo "---------------------------------------------------------------"
echo "Restoring network between brokers to restore normal replication"
echo "---------------------------------------------------------------"

kubectl apply -f ./network-policies/allow-regular-traffic

echo "> Kafka broker replication restored"
