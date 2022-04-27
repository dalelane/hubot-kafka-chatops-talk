#!/bin/sh

open $(kubectl get route -n prometheus-ns prometheus -o jsonpath='http://{.status.ingress[0].host}')
