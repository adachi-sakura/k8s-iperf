#!/bin/sh
set -eu

cd $(dirname $0)

csv="/tmp/result.csv"



scripts/setup.sh
scripts/run.sh ${csv}
scripts/cleanup.sh

config="gok8s-cfg"
kubectl create configmap ${config} --from-file=$(basename ${csv})

prom-config="prom-config"
host=$(kubectl get svc --all-namespaces | awk '$2=="prometheus"{print $4}')
port=$(kubectl get svc --all-namespaces | awk '$2=="prometheus"{print $6}' | cut -d '/' -f1|cut -d ':' -f1)
kubectl create configmap ${prom-config} --from-literal=PROMETHEUS_SERVICE_HOST=${host} --from-literal=PROMETHEUS_SERVICE_PORT=${port}