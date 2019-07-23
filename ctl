#!/bin/bash

function start_ipsec {
    if [ $(docker inspect -f '{{.State.Running}}' ipsec-vpn-server) != "true" ];
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

case $1 in

    start)
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
	docker build -t development .
	;;
    *)
        echo "start|stop|shell|ps"
        ;;
esac


        
