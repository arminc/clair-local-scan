#!/bin/bash

set -ex

CONTAINER="${1:-clair}"
COUNTER=1
MAX=360

while true; do
    if docker logs "${CONTAINER}" 2>&1 | grep "starting background updates" >&/dev/null
    then
        break
    fi

    if docker logs "${CONTAINER}" 2>&1 | grep "ERROR" >&/dev/null
    then
        docker logs -n 25 "${CONTAINER}"
        echo "Error during update." >&2
        exit 1
    fi

    docker logs -n 1 "${CONTAINER}"
    sleep 10
    ((COUNTER++))

    if [ "${COUNTER}" -eq "${MAX}" ]; then
        echo "Took to long"
        exit 1
    fi
done
echo ""
