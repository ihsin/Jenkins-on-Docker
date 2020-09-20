#!/bin/sh
PORT_HTTP=9090
PORT_JAVA_API=50000
#port 50000 gives access to a remote Java (JIRA) API.

JENKINS_HOME="$HOME/Jenkins/JenkinsHome/"

[[ ! -d ${JENKINS_HOME} ]] && mkdir -p $JENKINS_HOME && chmod 0777 $JENKINS_HOME

CONTAINER_NAME="$(whoami)-jenkins"

echo -e "\n###STOPPING ${CONTAINER_NAME}###\n"
docker stop ${CONTAINER_NAME}
[[ $? != 0 ]] && echo -e "\nError: failed to stop container: ${CONTAINER_NAME}\n" && exit 1
sleep 2

echo -e "\n###REMOVING ${CONTAINER_NAME}###\n"
docker rm ${CONTAINER_NAME}
[[ $? != 0 ]] && echo -e "\nError: failed to remove container: ${CONTAINER_NAME}\n" && exit 1
sleep 2

docker run -d \
 -p 9090:8080 \
 -p 50000:50000 \
 -v ${JENKINS_HOME}:/var/jenkins_home \
 --name ${CONTAINER_NAME} jenkins

[[ $? == 0 ]] && echo -e "\nYour webserver runs at: $(hostname -f):${PORT_HTTP} (with jenkins home dir on VM: ${JENKINS_HOME}).\n" || echo -e "\nError: Failed to run Jenkins Image"
