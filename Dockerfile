FROM sickp/alpine-node:9.2.1-r1

ARG USER_ID
ARG USER_NAME
ARG USER_GROUP=100
ARG BASE_DIR=/app
ARG APP_DIR=${BASE_DIR}/src

RUN set -ex \
  && apk add --no-cache \
    bash \
    shadow

RUN set -ex \
  && mkdir -p $APP_DIR \
  && chown -R $USER_ID.$USER_GROUP $BASE_DIR \
  && usermod -g $USER_GROUP $USER_NAME

WORKDIR /app/src

USER $USER_ID
WORKDIR /app/src
