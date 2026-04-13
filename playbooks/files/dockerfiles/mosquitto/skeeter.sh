#!/bin/bash

mosquitto -c mosquitto.conf -d

while true; do
	sleep 10
	color=$(ls /colors | sort -R | tail -1 | while read file; do cat /colors/$file ; done)
	now=$(date)
	dude=$(whoami)
	mosquitto_pub -h localhost -t "timecheck" -m "$now"
	mosquitto_pub -h localhost -t "randomcolor" -m "$color"
	mosquitto_pub -h localhost -t "dude" -m "$dude"

	
done
