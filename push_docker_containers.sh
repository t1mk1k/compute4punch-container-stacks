#!/bin/bash
set -e

CONTAINERS=$(ls */[Dd]ockerfile)
DATE=$(date +%Y%m%d)

for CONTAINER in $CONTAINERS; do
  CONTAINER_NAME=${CONTAINER/\/[Dd]ockerfile/}
  if [ "$CONTAINER_NAME" == "linc-wn" ] || [ "$CONTAINER_NAME" == "htcondor-wn" ] || [ "$CONTAINER_NAME" == "wlcg-wn" ]
  then
    continue
  fi
  docker pull $CI_REGISTRY_IMAGE/$CONTAINER_NAME:$CI_COMMIT_SHA
  docker tag $CI_REGISTRY_IMAGE/$CONTAINER_NAME:$CI_COMMIT_SHA $CI_REGISTRY_IMAGE/$CONTAINER_NAME:latest
  docker tag $CI_REGISTRY_IMAGE/$CONTAINER_NAME:$CI_COMMIT_SHA $CI_REGISTRY_IMAGE/$CONTAINER_NAME:$DATE
  docker push $CI_REGISTRY_IMAGE/$CONTAINER_NAME:latest
  docker push $CI_REGISTRY_IMAGE/$CONTAINER_NAME:$DATE
done
