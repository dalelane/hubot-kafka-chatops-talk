#!/bin/sh

echo "--------------------------------------------------------------"
echo "Installing the Prometheus operator that will set up Prometheus"
echo "--------------------------------------------------------------"

echo "creating Operator installation"
kubectl apply -f ./prometheus-operator/operatorgroup.yaml
kubectl apply -f ./prometheus-operator/subscription.yaml

echo "Waiting for InstallPlan to be created"
INSTALL_PLAN=""
while [ -z "$INSTALL_PLAN" ]
do
    INSTALL_PLAN=`kubectl get subscription prometheus -n prometheus-ns -ojsonpath='{.status.installPlanRef.name}'`
done

echo "Waiting for install plan to complete"
INSTALL_PHASE="Installing"
while [ "$INSTALL_PHASE" = "Installing" ]
do
    INSTALL_PHASE=`kubectl get installplan $INSTALL_PLAN -n prometheus-ns -ojsonpath='{.status.phase}'`
    sleep 10
done

if [ "$INSTALL_PHASE" = "Complete" ]; then
    echo "> Prometheus operator is ready"
    exit 0
fi
exit 1
