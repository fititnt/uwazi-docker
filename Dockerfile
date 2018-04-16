FROM node:6-slim
LABEL maintainer="Emerson Rocha <rocha@ieee.org>"

# see https://github.com/nodejs/docker-node#how-to-use-this-image

## Install common software
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
  bzip2 \
  dh-autoreconf \
  git \
  libpng-dev

## Download Uwazi
RUN git clone -b 1.1 --single-branch --depth=1 https://github.com/huridocs/uwazi.git /home/node/uwazi/ \
  && chown node:node -R /home/node/uwazi/ \
  && cd /home/node/uwazi/ \
  && yarn install \
  && yarn production-build

ADD --chown=node:node ./scripts/patch/uwazi/database/reindex_elastic.js /home/node/uwazi/uwazi/database/reindex_elastic.js

WORKDIR /home/node/uwazi/
COPY --chown=node:node docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
