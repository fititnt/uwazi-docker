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
docker compose up elasticsearch mongo

# To run on background use -d param
docker compose up -d elasticsearch mongo

# Stop all containers from uwazi-docker after they where not more need and
# avoid they stay running even after you reboot your operational system
docker compose down
```

The following step is optional if you want to populate the databases not using
uwazi-docker.

```bash
docker compose run -e IS_FIRST_RUN=true --rm uwazi
```

## Create your own repository
If you already does not have, [join on GitHub with a free account](https://github.com/join).
Then go to <https://github.com/huridocs/uwazi> and click fork.

![fork-uwazi](https://user-images.githubusercontent.com/812299/39087980-7020a3da-4580-11e8-8fe3-57b1c09e962c.png)

You now have a forked version at <https://github.com/YOUR-USERNAME/uwazi>.
A few steps more and you [can create pull requests and contribute](https://help.github.com/articles/creating-a-pull-request/).

Extra links:
- Install GitHub Desktop (Windows and Mac): <https://desktop.github.com/>
  - This link is great for who is new to git and GitHub and is not using linux.
    This guide assume use of command line interface
- Interactive Git Tutorial: <https://try.github.io>
  - This is a good tutorial for who uses command like to work with git.

## Working with Uwazi - your local fork
**Important: some commands will only work on uwazi (not the docker-uwazi) folder**


> For complete instructions about how to run Uwazi for development, see
the oficial guide at <https://github.com/huridocs/uwazi#development>. This
document is a quick start.

```bash
# Clone your forked repository to a local folder
git clone git@github.com:YOUR-USERNAME/uwazi.git
cd uwazi

# Install node modules used by Uwazi.
yarn install

# Initialize databases (Mongo and Elastic Search) with Uwazi default blank values
# WARNING: if you already is using Uwazi and have Mongo and Elastic Search with
#          test or real data, this can potentially reset to initial state
#          depending of your environment variables like DATABASE_NAME and
#          ELASTICSEARCH_URL.
yarn blank-state
```

Now, each time you want to run, execute

```bash
yarn hot
```

**If everything goes ok, you will see something similar to this**:

![yarn hot](https://user-images.githubusercontent.com/812299/39088499-a3d0783c-4589-11e8-997a-1703b4013617.png)

**Uwazi welcome screen by default will show at <http://localhost:3000/>**

![uwazi welcome screen](https://user-images.githubusercontent.com/812299/39088501-a8d3c5aa-4589-11e8-9997-bfbd64820f28.png)

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

Protip: **0.0.0.0:9200->9200/tcp** means that a container named
_uwazidocker_elasticsearch_1_ is redirecting its internal port 9200 to your
local development machine. **9300/tcp** means the same container have the port
9300 open but its only acessible inside a docker network.

### Debug Mongo and Elastic Search

```bash

# See log messages of Mongo and Elastic Search
docker compose logs -f mongo elasticsearch

# Want some GUI to see what is happening on MongoDB? Use nosqlclient
docker compose up -d mongo-gui-mongoclient

# Want some GUI to see what is happening on Elastic Search? Try Dejavu
docker compose up -d elasticsearch-gui-dejavu
```
### Configure ports of Mongo and Elastic Search

At this point, you have to edit the file [docker compose.yml](docker compose.yml)
and edit the hardcored values.

Protip: the most common error of using uwazi-docker with Uwazi a port is already
used by another container or the installed Mongo / Elastic Search on your
machine.
