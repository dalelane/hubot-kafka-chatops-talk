#!/bin/sh

set -e

echo "--------------------------------"
echo "Installing the Hubot chatops bot"
echo "--------------------------------"

echo "setting up redis for hubot to use for persistence"
oc apply -f ./hubot/redis-scc.yaml
oc adm policy add-scc-to-user redis-enterprise-scc system:serviceaccount:hubot-ns:redis-enterprise-operator
oc adm policy add-scc-to-user redis-enterprise-scc system:serviceaccount:hubot-ns:redis-cluster
kubectl apply -f ./hubot/hubot-operatorgroup.yaml
kubectl apply -f ./hubot/redis-operator-subscription.yaml

echo "Waiting for redis operator installplan to be created"
INSTALL_PLAN=""
while [ -z "$INSTALL_PLAN" ]
do
    INSTALL_PLAN=`kubectl get subscription redis-enterprise-operator-cert -n hubot-ns -ojsonpath='{.status.installPlanRef.name}'`
done

echo "Waiting for redis operator installplan to complete"
INSTALL_PHASE="Installing"
while [ "$INSTALL_PHASE" = "Installing" ]
do
    INSTALL_PHASE=`kubectl get installplan $INSTALL_PLAN -n hubot-ns -ojsonpath='{.status.phase}'`
    echo "$INSTALL_PHASE"
    sleep 10
done

echo "creating the Redis cluster"
kubectl apply -f ./hubot/redis-cluster.yaml

echo "waiting for redis cluster to be ready"
REDIS_CLUSTER_STATUS=""
while [ "$REDIS_CLUSTER_STATUS" != "Running" ]
do
    REDIS_CLUSTER_STATUS=`kubectl get RedisEnterpriseCluster redis-cluster -n hubot-ns -o jsonpath='{.status.state}'`
done

echo "creating the Redis DB"
kubectl apply -f ./hubot/redis-db.yaml

echo "waiting for redis db to be ready"
REDIS_DB_STATUS=""
while [ "$REDIS_DB_STATUS" != "active" ]
do
    REDIS_DB_STATUS=`kubectl get redisenterprisedatabase  redis-database -n hubot-ns -o jsonpath='{.status.status}'`
done

# for redis admin through the UI:
# kubectl apply -f ./hubot/redis-ui-route.yaml
# kubectl get secret redis-cluster -o jsonpath='{.data.username}' | base64 -d
# kubectl get secret redis-cluster -o jsonpath='{.data.password}' | base64 -d

# for app access to redis:
# kubectl get secret redb-redis-database -o jsonpath='{.data.password}' | base64 -d
# kubectl get secret redb-redis-database -o jsonpath='{.data.service_name}' | base64 -d

echo "storing redis connection details where hubot can access it"
REDIS_HOST=$(kubectl get secret -n hubot-ns redb-redis-database -o jsonpath='{.data.service_name}' | base64 -d)
REDIS_PORT=$(kubectl get svc -n hubot-ns $REDIS_HOST -o jsonpath='{.spec.ports[0].port}')
REDIS_PASS=$(kubectl get secret -n hubot-ns redb-redis-database -o jsonpath='{.data.password}' | base64 -d)
REDIS_CONNECTION_URL="redis://:$REDIS_PASS@$REDIS_HOST:$REDIS_PORT/hubot"
kubectl create secret generic redis-db-connection-details -n hubot-ns \
    --from-literal=url="$REDIS_CONNECTION_URL" \
    --from-literal=host="$REDIS_HOST" --from-literal=port="$REDIS_PORT" \
    --dry-run=client -o yaml | kubectl apply -n hubot-ns -f -

echo "storing grafana connection details where hubot can access it"
GRAFANA_HOST="$(kubectl get route -ngrafana-ns grafana-route -o jsonpath='{.status.ingress[0].host}')"
GRAFANA_URL="https://$GRAFANA_HOST"
GRAFANA_ADMIN_PASS=$(kubectl get secret -ngrafana-ns grafana-admin-credentials -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 --decode)
NEW_GRAFANA_APIKEY_API="https://admin:$GRAFANA_ADMIN_PASS@$GRAFANA_HOST/api/auth/keys"
GRAFANA_APIKEY=$(curl -s -X POST -H "Content-Type: application/json" --data '{"role":"Admin","name":"hubot"}' $NEW_GRAFANA_APIKEY_API | jq -r .key)
kubectl create secret generic grafana-connection-details -n hubot-ns  \
    --from-literal=url="$GRAFANA_URL" \
    --from-literal=apikey="$GRAFANA_APIKEY" \
    --dry-run=client -o yaml | kubectl apply -n hubot-ns -f -

echo "storing openshift console details where hubot can access it"
kubectl create configmap openshift-console-details -n hubot-ns \
    --from-literal=url=$(kubectl get route -n openshift-console console -o jsonpath='https://{.spec.host}') \
    --dry-run=client -o yaml | kubectl apply -n hubot-ns -f -

echo "installing hubot"
kubectl apply -f ./hubot/hubot-serviceaccount.yaml
kubectl apply -f ./hubot/hubot-role.yaml
kubectl apply -f ./hubot/hubot-role-binding.yaml
oc apply -f ./hubot/hubot-scc.yaml
oc adm policy add-scc-to-user hubot-scc system:serviceaccount:hubot-ns:hubot-sa
oc adm policy add-scc-to-user hubot-scc -z hubot-sa
kubectl apply -f ./hubot/hubot-slack-secret.yaml
kubectl apply -f ./hubot/hubot-pagerduty-secret.yaml
kubectl apply -f ./hubot/hubot-deployment.yaml

echo "> Hubot is ready"
