#!/usr/bin/env sh
set -e

FUNK_UUID=$1
FUNK_TIMEOUT=$2
FUNK_IMAGE=$3
shift; shift; shift
FUNK_CMD=$@

FUNK_SERVICE=f-$FUNK_UUID
FUNK_OUTPUT=output_$FUNK_UUID

echo "funk runner starting"
echo "uuid: $FUNK_UUID"
echo "image: $FUNK_IMAGE"
echo "cmd: $FUNK_CMD"
echo "timeout: $FUNK_TIMEOUT"

kontena service create --cmd "sleep $FUNK_TIMEOUT" --instances 1 $FUNK_SERVICE $FUNK_IMAGE
kontena service start $FUNK_SERVICE

while true; do
  containers=$(kontena service containers $FUNK_SERVICE)
  if [ "$containers" != "" ]; then
    echo $containers
    break
  fi
  sleep 0.1
done

set +e
  output=$(kontena service exec $FUNK_SERVICE $FUNK_CMD > $FUNK_OUTPUT)
  exec_exit_code=$?
set -e

set +e
  kontena service rm --force $FUNK_SERVICE
set -e
