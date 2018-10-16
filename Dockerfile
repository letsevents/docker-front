FROM node:10.12.0-slim

RUN set -ex \
  && DEBIAN_FRONTEND=noninteractive apt-get update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y --no-install-recommends \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python \
    build-essential \
  && DEBIAN_FRONTEND=noninteractive apt-get -y clean \
  && rm -rf /var/lib/apt/lists/*

ARG USER_NAME=node
ARG USER_GROUP=users
ARG APP_DIR=/app

RUN set -ex \
  && mkdir -p $APP_DIR \
  && chown -R $USER_NAME.$USER_GROUP $APP_DIR \
  && usermod -g $USER_GROUP $USER_NAME

WORKDIR $APP_DIR

USER $USER_NAME
