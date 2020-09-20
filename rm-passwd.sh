#!/bin/bash

CONTAINER_NAME="$(whoami)-jenkins"

if [ -n $(docker ps|grep {CONTAINER_NAME})]; then
docker exec -it ${CONTAINER_NAME} \
 sed -i 's/<useSecurity>true<\/useSecurity>/<useSecurity>false<\/useSecurity>/g' \
 /var/jenkins_home/config.xml
fi
