#!/bin/sh
set -eu

kubectl create -f iperf-yaml/

until $(kubectl get po -l app=orchestrator -o jsonpath='{.items[0].status.containerStatuses[0].ready}'); do
	echo "Waiting for orchestrator to start..."
	sleep 5
done

echo "Orchestrator start to work..."
echo