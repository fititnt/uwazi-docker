FROM node:6-slim
LABEL maintainer="Emerson Rocha <rocha@ieee.org>"

# see https://github.com/nodejs/docker-node#how-to-use-this-image

## Install common software
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
  git

## Download Uwazi
RUN git clone -b master --single-branch --depth=1 https://github.com/huridocs/uwazi.git /home/node/uwazi/

# RUN "ls /home/node/uwazi-development"

