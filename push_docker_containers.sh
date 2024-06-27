#!/bin/bash
set -e

CONTAINER_NAME=$1
DATE=$(date +%Y%m%d)

docker pull $CI_REGISTRY_IMAGE/$CONTAINER_NAME:$CI_COMMIT_SHA
docker tag $CI_REGISTRY_IMAGE/$CONTAINER_NAME:$CI_COMMIT_SHA $CI_REGISTRY_IMAGE/$CONTAINER_NAME:latest
docker tag $CI_REGISTRY_IMAGE/$CONTAINER_NAME:$CI_COMMIT_SHA $CI_REGISTRY_IMAGE/$CONTAINER_NAME:$DATE
docker push $CI_REGISTRY_IMAGE/$CONTAINER_NAME:latest
docker push $CI_REGISTRY_IMAGE/$CONTAINER_NAME:$DATE

# Cleanup docker images on CI runner again
docker rmi $CI_REGISTRY_IMAGE/$CONTAINER_NAME:latest
docker rmi $CI_REGISTRY_IMAGE/$CONTAINER_NAME:$DATE
docker rmi $CI_REGISTRY_IMAGE/$CONTAINER_NAME:$CI_COMMIT_SHA
