#!/bin/bash

eval $(minikube docker-env)

export INGRESS_PORT=$(kubectl \
	--namespace istio-system \
	get service istio-ingressgateway \
	--output jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')

export INGRESS_HOST=$(minikube ip):$INGRESS_PORT