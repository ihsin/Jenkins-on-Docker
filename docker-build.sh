#!/bin/bash

if [ ! -f Dockerfile ]; then
   echo "No Dockerfile found in this directory.";
   exit 1;
fi

IMAGENAME="jenkins"
IMAGETAG="latest"

# build Docker image
docker build --pull --no-cache --force-rm -t ${IMAGENAME}:${IMAGETAG} .

