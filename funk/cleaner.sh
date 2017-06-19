#!/usr/bin/env sh
set -e

echo "Cleaner starting.."
while true; do
  set +e
    funk_services=$(kontena service ls -q | grep "/f-")
  set -e

  echo "Current services:"
  printf "$funk_services"
  echo ""
  echo "--"

  echo "$(date) sleeping for $FUNK_TIMEOUT+1"
  sleep $FUNK_TIMEOUT
  sleep 1

  echo "$(date) starting cleaning..."
  for funk_service in $funk_services; do
    echo "cleaning $funk_service"
    set +e
      kontena service rm --force $funk_service
    set -e
  done
  echo "$(date) cleaning completed."

  sleep 1
done
