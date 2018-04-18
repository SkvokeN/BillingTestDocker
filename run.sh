#!/usr/bin/env bash

if [ "$#" -lt 3 ]; then
    echo "Params required to run command in a container: [service name] [env] [command], e.g.: sh run.sh php-cli dev app/console cache:clear"
    exit 0
fi

SERVICE="$1"; shift
COMMAND="$@";

export HOST_UID=$(id -u)

docker-compose run --rm --no-deps -u $(id -u):$(id -g) ${SERVICE} ${COMMAND}
