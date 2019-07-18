
#!/bin/bash


case $1 in

    start)
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
