#!/bin/bash

CONTAINERS=$(ls */[Dd]ockerfile)

for CONTAINER in $CONTAINERS; do
  CONTAINER_NAME=${CONTAINER/\/[Dd]ockerfile/}

  export CONTAINER_NAME
  envsubst < .docker-build.tmpl >> generated-config.yaml
done
