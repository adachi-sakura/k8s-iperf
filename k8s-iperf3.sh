#!/bin/sh
set -eu

cd $(dirname $0)

csv="/tmp/result.csv"


scripts/setup.sh
scripts/run.sh ${csv}
scripts/cleanup.sh

config="gok8s-cfg"

#prom-config="prom-config"
host=$(kubectl get svc --all-namespaces | awk '$2=="prometheus"{print $4}')
port=$(kubectl get svc --all-namespaces | awk '$2=="prometheus"{print $6}' | cut -d '/' -f1|cut -d ':' -f1)
kubectl create -n ${1:-allocation} configmap ${config} --from-literal=PROMETHEUS_SERVICE_HOST=${host} --from-literal=PROMETHEUS_SERVICE_PORT=${port} --from-file=$(basename ${csv})

#kubectl get nodes | tail -2 | awk '$3!="master"{system("kubectl label node "$1" container-allocation/name="$1)}'