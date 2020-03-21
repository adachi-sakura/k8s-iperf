#!/bin/sh
set -eu

cd $(dirname $0)

csv="/tmp/result.csv"
config="gok8s-cfg"

scripts/setup.sh
scripts/run.sh ${csv}
scripts/cleanup.sh

kubectl create configmap ${config} --from-file=$(basename ${csv})