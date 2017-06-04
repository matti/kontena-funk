#!/usr/bin/env sh

while true; do
  funk_services=$(kontena service ls | cut -f2 -d' ' | grep "^f-")
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
done
