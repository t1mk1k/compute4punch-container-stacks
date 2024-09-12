#!/bin/bash

#exclude h4leptons, since there is a bug when a Docker image contains Kernel 2.6
CONTAINERS=$(ls */[Dd]ockerfile | grep -v h4leptons)

for CONTAINER in $CONTAINERS; do
  CONTAINER_NAME=${CONTAINER/\/[Dd]ockerfile/}

  export CONTAINER_NAME
  envsubst < .docker-build.tmpl >> generated-config.yaml
done
