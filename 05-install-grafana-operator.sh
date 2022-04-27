#!/bin/sh

echo "--------------------------------------------------------"
echo "Installing the Grafana operator that will set up Grafana"
echo "--------------------------------------------------------"

echo "creating Operator installation"
kubectl apply -f ./grafana-operator/operatorgroup.yaml
kubectl apply -f ./grafana-operator/subscription.yaml

echo "Waiting for InstallPlan to be created"
INSTALL_PLAN=""
while [ -z "$INSTALL_PLAN" ]
do
    INSTALL_PLAN=`kubectl get subscription grafana-operator -n grafana-ns -ojsonpath='{.status.installPlanRef.name}'`
done

echo "Waiting for install plan to complete"
INSTALL_PHASE="Installing"
while [ "$INSTALL_PHASE" = "Installing" ]
do
    INSTALL_PHASE=`kubectl get installplan $INSTALL_PLAN -n grafana-ns -ojsonpath='{.status.phase}'`
    sleep 10
done

if [ "$INSTALL_PHASE" = "Complete" ]; then
    echo "> Grafana operator is ready"
    exit 0
fi
exit 1
