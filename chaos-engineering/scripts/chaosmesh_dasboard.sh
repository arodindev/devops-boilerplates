#!/bin/bash

DASHBOARD_POD=$(kubectl get pods -n chaos-testing --selector=app.kubernetes.io/component=chaos-dashboard --output=jsonpath={.items..metadata.name})
DASHBOARD_PORT=$(kubectl get deploy chaos-dashboard -n chaos-testing -o=jsonpath="{.spec.template.spec.containers[0].ports[0].containerPort}{'\n'}")

echo "open http://localhost:8888"

kubectl port-forward -n chaos-testing $DASHBOARD_POD 8888:$DASHBOARD_PORT