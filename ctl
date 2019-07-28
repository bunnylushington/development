#!/bin/bash

export SSH_AUTH_SOCK

function start_ipsec {
    if [ $(docker inspect -f '{{.State.Running}}' ipsec-vpn-server) != "true" ]\
	    || [ $? -ne 0 ]
    then
        docker run \
	             --name ipsec-vpn-server \
	             --env-file ./.vpn-env \
	             --restart=always \
	             -p 500:500/udp \
	             -p 4500:4500/udp \
	             -d --privileged \
	             hwdsl2/ipsec-vpn-server
    fi
}

function start_ssh {
    if [[ ! -e /ssh-agent ]]; then
        eval $(ssh-agent -a /ssh-agent) >/dev/null
        echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
    else
        export SSH_AUTH_SOCK=/ssh-agent
    fi
}

case $1 in

    start)
        start_ssh
        start_ipsec
        mkdir -p /projects
        HOSTNAME=$(hostname) docker stack deploy -c docker-compose.yml dev
        ;;
    stop)
        docker stack rm dev
        ;;
    ps)
        docker stack ps dev
        ;;
    shell)
        docker attach $(docker ps --filter name=dev_tools \
                               --format "{{.ID}}")
        ;;
    build)
        mkdir ./.ssh && chmod 700 ./.ssh
        cp ~/.ssh/* ./.ssh
        chmod 600 .ssh/*
	      docker build -t development .
	;;
    *)
        echo "start|stop|shell|ps"
        ;;
esac




