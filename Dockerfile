FROM sickp/alpine-node:9.2.1-r1

RUN set -ex \
  && apk add --no-cache \
    bash \
    shadow

ARG USER_ID=1000
ARG USER_NAME=node
ARG USER_GROUP=100
ARG BASE_DIR=/app
ARG APP_DIR=${BASE_DIR}/src

RUN set -ex \
  && mkdir -p $APP_DIR \
  && chown -R $USER_ID.$USER_GROUP $BASE_DIR \
  && usermod -g $USER_GROUP $USER_NAME

RUN apk update
RUN apk add python

WORKDIR /app/src

USER $USER_ID
WORKDIR /app/src
