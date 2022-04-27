#!/bin/sh

open $(kubectl get route -n prometheus-ns alertmanager -o jsonpath='http://{.status.ingress[0].host}')
