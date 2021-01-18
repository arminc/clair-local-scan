#!/bin/bash

CONTAINER="${1:-clair}"

while true
do
    docker logs "$CONTAINER" | grep "libvuln initialized" >& /dev/null
    if [ $? == 0 ]; then
        break
    fi

    docker logs "$CONTAINER" | grep "updating errors" >& /dev/null
    if [ $? == 0 ]; then
        echo "Error during update." >&2
        exit 1
    fi

    docker logs "$CONTAINER" | grep "warning" >& /dev/null
    if [ $? == 0 ]; then
        echo "Warning during update." >&2
    fi

    echo -n "."
    sleep 10
done
echo ""
