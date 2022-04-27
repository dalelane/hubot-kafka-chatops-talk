#!/bin/sh

echo "----------------------------------------------------------------"
echo "Installing the Kafka operator that will set up the Kafka cluster"
echo "----------------------------------------------------------------"

echo "creating Operator installation"
kubectl apply -f ./strimzi-kafka-operator/operatorgroup.yaml
kubectl apply -f ./strimzi-kafka-operator/subscription.yaml

echo "Waiting for InstallPlan to be created"
INSTALL_PLAN=""
while [ -z "$INSTALL_PLAN" ]
do
    INSTALL_PLAN=`kubectl get subscription strimzi-kafka-operator -n kafka-ns -ojsonpath='{.status.installPlanRef.name}'`
done

echo "Waiting for install plan to complete"
INSTALL_PHASE="Installing"
while [ "$INSTALL_PHASE" = "Installing" ]
do
    INSTALL_PHASE=`kubectl get installplan $INSTALL_PLAN -n kafka-ns -ojsonpath='{.status.phase}'`
    sleep 10
done

if [ "$INSTALL_PHASE" = "Complete" ]; then

    echo "modifying Kafka Operator config to prevent automatic network policy creation"
    echo " as we want to modify network policies manually to simulate network problems"
    kubectl patch ClusterServiceVersion strimzi-cluster-operator.v0.28.0 -n kafka-ns \
        --type json --patch-file network-policies/patch-strimi-operator.json

    echo "> Kafka operator is ready"
    exit 0
fi
exit 1
