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

# yarn blank-state
# yarn reindex
# yarn run-production

# WORKDIR /home/node/uwazi/
# RUN npm install

# RUN "ls /home/node/uwazi-development"

WORKDIR /home/node/uwazi/
COPY --chown=node docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 777 /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
