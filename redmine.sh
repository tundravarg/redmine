#!/bin/bash


DOCKER_IMAGE=redmine
CONNECT_CMD=sh


function help {
    echo "Commands: "
    echo "  help           - print this help"
    echo "  build          - build image"
    echo "  start          - run container"
    echo "  stop [<id>]    - stop single or specified container"
    echo "  stop-all       - stop all containers"
    echo "  restart [<id>] - restart or run single or specified container"
    echo "  ps             - list containers from this image"
    echo "  connect [<id>] - connect to single or specified container"
}

function build {
    docker image build -t $DOCKER_IMAGE .
}

function start {
    # -d | -it - Detached | Interactive mode
    # -p <local>:<remote> - Bind port
    # -v $(pwd)/<local>:<remote> - Bind path
    # -e <name>=<value> - Set env
    docker run \
        -d \
        -p 5432:5432 \
        -p 3072:3000 \
        -v "$(pwd)/share:/root/share" \
        -v "$(pwd)/data/postgres:/var/lib/postgresql/13/main" \
        $DOCKER_IMAGE
}

function stop {
    local container_id=$(_get_single_container_id $*)
    if [ -z "$container_id" ]
    then
        echo "Please specify an container id"
        return 1
    fi

    docker stop $container_id
}

function restart {
    if [ -z "$(ps -q)" ]
    then
        start
        return
    fi

    local container_id=$(_get_single_container_id $*)
    if [ -z "$container_id" ]
    then
        echo "Please specify an container id"
        return 1
    fi

    stop $container_id && start
}

function ps {
    docker ps -f ancestor=$DOCKER_IMAGE $*
}

function connect {
    local container_id=$(_get_single_container_id $*)
    if [ -z "$container_id" ]
    then
        echo "Please specify an container id"
        return 1
    fi

    docker exec -it $container_id $CONNECT_CMD
}


function _get_single_container_id {
    if [ ! -z "$*" ]; then echo "$*"; return; fi

    ids=""
    read -r -a ids <<< $(ps -q)
    if [ ${#ids[*]} -eq 1 ]; then echo $ids; fi
}


case $1 in
    "build")
        build ${*:2}
    ;;
    "start")
        start ${*:2}
    ;;
    "stop")
        stop ${*:2}
    ;;
    "stop-all")
        stop $(ps -q)
    ;;
    "restart")
        restart ${*:2}
    ;;
    "ps")
        ps ${*:2}
    ;;
    "connect")
        connect ${*:2}
    ;;
    "help" | *)
        help
    ;;
esac
