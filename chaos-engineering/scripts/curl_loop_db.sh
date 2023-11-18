#!/bin/bash

while true; do
	curl -i -H "Host: flaskapp.acme.com" \
		"http://$INGRESS_HOST/tasks"
	sleep 1
done
