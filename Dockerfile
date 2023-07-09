FROM node:18-bullseye
LABEL maintainer="Emerson Rocha <rocha@ieee.org>"

# see https://github.com/nodejs/docker-node#how-to-use-this-image

## Install common software
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
  bzip2 \
  dh-autoreconf \
  git \
  libpng-dev \
  libcurl3 \
  openssl \
  poppler-utils

RUN curl -fsSL https://pgp.mongodb.com/server-4.2.asc | \
   gpg -o /usr/share/keyrings/mongodb-server-4.2.gpg \
   --dearmor

RUN echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-4.2.gpg ] http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.2 main" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
RUN apt-get update
# RUN apt-get install -y mongodb-org-shell mongodb-org-tools 
RUN apt-get install -y mongodb-org-tools 
RUN apt-get clean && rm -rf /var/lib/apt/lists/*


# Install mongo & mongorestore (this is used only for database initialization, not on runtime)
# So much space need, see 'After this operation, 184 MB of additional disk space will be used.'
# RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 20691EEC35216C63CAF66CE1656408E390CFB1F5 \
#   && echo "deb http://repo.mongodb.org/apt/debian bullseye/mongodb-org/4.2 main" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list \
# RUN echo "deb http://repo.mongodb.org/apt/debian bullseye/mongodb-org/4.2 main" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list \
#   && apt-get update \
#   && apt-get install -y mongodb-org-shell mongodb-org-tools \
#   && apt-get clean && rm -rf /var/lib/apt/lists/*

# ## Download Uwazi v1.4
# RUN git clone -b v1.4 --single-branch --depth=1 https://github.com/huridocs/uwazi.git /home/node/uwazi/ \
## Download Uwazi v1.4
RUN git clone -b production --single-branch --depth=1 https://github.com/huridocs/uwazi.git /home/node/uwazi/ \
  && chown node:node -R /home/node/uwazi/ \
  && cd /home/node/uwazi/ \
  && yarn install \
  && yarn production-build

WORKDIR /home/node/uwazi/
COPY --chown=node:node docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
