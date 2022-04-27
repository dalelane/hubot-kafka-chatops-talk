#!/bin/sh

./00-setup-ocp.sh && \
    ./01-install-kafka-operator.sh && ./02-create-kafka-cluster.sh && \
    ./03-install-prometheus-operator.sh && ./04-create-prometheus-cluster.sh && \
    ./05-install-grafana-operator.sh && ./06-create-grafana-cluster.sh && ./07-create-grafana-dashboards.sh && \
    ./08-install-hubot.sh

echo "setup complete"
