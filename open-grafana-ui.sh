#!/bin/sh

echo "admin password: "
kubectl get secret -n grafana-ns grafana-admin-credentials -o jsonpath='{.data.GF_SECURITY_ADMIN_PASSWORD}' | base64 -d
echo ""

open $(kubectl get route -n grafana-ns grafana-route -o jsonpath='https://{.status.ingress[0].host}')
