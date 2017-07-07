#!/usr/bin/env sh
set -e

FUNK_UUID=$1
FUNK_TIMEOUT=$2
FUNK_IMAGE=$3
shift; shift; shift
FUNK_CMD=$@

FUNK_SERVICE=f-$FUNK_UUID
FUNK_OUTPUT=output_$FUNK_UUID
FUNK_COMPLETED=completed_$FUNK_UUID
FUNK_ENV=env_$FUNK_UUID
env_args=$(cat $FUNK_ENV)

echo "
-- funk runner starting"
echo "uuid: $FUNK_UUID"
echo "timeout: $FUNK_TIMEOUT"
echo "affinity: $FUNK_AFFINITY"
echo "image: $FUNK_IMAGE"
echo "cmd: $FUNK_CMD"
echo "env_args:
$env_args"

echo "
-- creating service"
kontena service create \
  $env_args \
  --affinity "$FUNK_AFFINITY" \
  --cmd "sleep $FUNK_TIMEOUT" \
  --instances 1 \
  -v /dev/shm:/dev/shm \
  $FUNK_SERVICE \
  $FUNK_IMAGE

echo "
-- starting service"
kontena service start $FUNK_SERVICE

printf "
-- waiting for containers to appear "
while true; do
  containers=$(kontena service containers $FUNK_SERVICE)
  if [ "$containers" != "" ]; then
    echo ""
    printf "$containers"
    echo ""
    break
  fi
  printf "."
  sleep 0.1
done

echo "
-- service $FUNK_SERVICE exec:"
set +e
  kontena service exec $FUNK_SERVICE $FUNK_CMD | tee $FUNK_OUTPUT
set -e

#without this processes started by FUNK_CMD might be running until the timeout
echo "
-- service $FUNK_SERVICE rm:"
set +e
  kontena service rm --force $FUNK_SERVICE
set -e
