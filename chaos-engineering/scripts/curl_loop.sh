#!/bin/bash

while true; do
	curl -i -H "Host: repeater.acme.com" \
		"http://$INGRESS_HOST?addr=http://flaskapp"
	sleep 5
done