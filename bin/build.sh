#!/usr/bin/env bash

BASE_DIR=$(realpath $(dirname $0)/..)
DOCKER_USER=lets
IMAGE=docker-node
REPO=$DOCKER_USER/$IMAGE

cd $BASE_DIR \
  && docker build --build-arg USER_NAME=node --rm -t $REPO:latest . \
  && docker tag $REPO:latest $REPO:$(cat VERSION) \
  && echo "$REPO:$(cat VERSION) is the lastest" \
  && echo -e "\nUse: docker push ${REPO} to upload this image"
