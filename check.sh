#!/bin/bash

while true
do
    docker logs clair | grep "update finished" >& /dev/null
    if [ $? == 0 ]; then
        break
    fi

    docker logs clair | grep "an error occured" >& /dev/null
    if [ $? == 0 ]; then
        echo "Error happend" >&2
        docker logs clair
        exit 1
    fi

    echo -n "."
    sleep 10
done
echo ""