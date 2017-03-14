#!/bin/bash

while true
do
    docker logs $1 | grep "updater: update finished" >& /dev/null
    if [ $? == 0 ]; then
        break
    fi

    docker logs $1 | grep "updater: an error occured" >& /dev/null
    if [ $? == 0 ]; then
        echo ""
        echo "error during vulnerabilities database update" >&2
        exit 1
    fi

    echo -n "."
    sleep 30
done
echo ""