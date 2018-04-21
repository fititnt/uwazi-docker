# Use of uwazi-docker for development of Uwazi
The [README.md](README.md) have short explanation about how to use uwazi-docker
fully dockered. This document aims to explain extra information for who is
who is updating the code of Uwazi software and using this uwazi-docker only
for it's dependencies.

## Initial configuration

_Note: will not be explained how to install Elastic Search and MongoDB databases
since you can use both from uwazi-docker_.

### Install docker
Instructions about how to install docker are explained on [requirements](requirements.md).

### Install Uwazi requeriments
> **Important note: this topic in special is not granteed to be updated with
lastest versions of Uwazi, so it's recommended to check at maintainer repository
at <https://github.com/huridocs/uwazi>**. Pull requests are welcome.

#### NodeJS

##### NVM Package manager
Is possible to install a specific version of a software on your system. But is
a good idea use a package manager.

See how to install NVM at <https://github.com/creationix/nvm#installation>.

##### Yarn

See Yarn installation at <https://yarnpkg.com/lang/en/docs/install/>.

##### MongoDB Client
_This step is not necessary if use install instructions at
[README.md#install](README.md#install)_

Some steps may need that you install the **mongo client** to be able to import
the import data from commands `mongo` and `mongorestore`. See Mongo installation
steps at <https://docs.mongodb.com/manual/installation/>.

## Working with MongoDB and Elastic Search (containised on uwazi-docker)
**Important: these require be executed on same directory of uwazi-docker**. They
will not work on uwazi directory. A good idea is have at least two different
tabs.

```bash
# To run and see messages
docker-compose up elasticsearch mongo

# To run on background use -d param
docker-compose up -d elasticsearch mongo
```

## Extra tips

### docker ps - See what is running

`docker ps` is a command to show what is running on docker. A comon problem
to make a containers not run is the ports already used by a installed version
of Mongo or Elastic Search on your machine or when a same container is lauched
more than one time.

One example of output.

```bash
$ docker ps
CONTAINER ID        IMAGE                                                 COMMAND                  CREATED             STATUS              PORTS                              NAMES
22d753159257        docker.elastic.co/elasticsearch/elasticsearch:5.5.3   "elasticsearch -Expa…"   5 days ago          Up 3 minutes        0.0.0.0:9200->9200/tcp, 9300/tcp   uwazidocker_elasticsearch_1
752a0a2ab505        mongo:3.4                                             "docker-entrypoint.s…"   5 days ago          Up 3 minutes        0.0.0.0:27017->27017/tcp           uwazidocker_mongo_1
```