FROM heroku/heroku:20

#######################################
# NODE + NPM INSTALLATION THROUGH NVM #
#######################################

ENV NVM_DIR /usr/local/nvm

ENV NODE_VERSION 18.18.2

RUN mkdir -p $NVM_DIR

# Although g++ is available on the base ubuntu image at build time, it is not available
# at runtime. We will need it to compile npm packages
RUN apt-get update && apt-get install g++ -y

# 1) NVM
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# 2) NODE + NPM
RUN source $NVM_DIR/nvm.sh \
  && nvm install $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

#############################
# DOCKER USER CONFIGURATION #
#############################

ARG USER_ID=1000
ARG USER_NAME=node
ARG USER_GROUP=100
ARG BASE_DIR=/app
ARG APP_DIR=${BASE_DIR}/src

RUN set -ex \
  && mkdir -p $APP_DIR \
  && useradd -m $USER_NAME -u $USER_ID \
  && chown -R $USER_ID.$USER_GROUP $BASE_DIR \
  && usermod -g $USER_GROUP $USER_NAME

USER $USER_ID
WORKDIR $APP_DIR