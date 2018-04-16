# Uwazi with Docker
This work-in-progress repository allows you to run the
[Uwazi](http://www.uwazi.io) using [Docker containers](https://docker.com). It
can be a good alternative if you are testing the software and have no
proeficiency with the entire stack of applications involved.

**The Uwazi software is available in the [github.com/huridocs/uwazi](https://github.com/huridocs/uwazi/)
repository.**

## What is Uwazi?

> In Swahili, Uwazi means “openness.” HURIDOCS designed Uwazi to make human rights
information more open and accessible to the defenders who need it.
[Uwazi](http://www.uwazi.io) is a web-based platform that goes beyond just
storing and tagging documents. Users work directly with the text inside these
otherwise uneditable documents to add new layers of information.
[Uwazi is a web-based, open-source solution](https://github.com/huridocs/uwazi/)
for building and sharing document collections.

See also [History of Uwazi](https://github.com/huridocs/uwazi/wiki/History-of-Uwazi).

## Usage
The [uwazi-docker](https://github.com/fititnt/uwazi-docker) requires
[docker-compose](https://docs.docker.com/compose/install/) installed.

> At this moment, the Dockerfile of the uwazi is not ready, only it's external
> dependencies (Elastic Search and MongoDB), so you will also need install
[NVM](https://github.com/creationix/nvm) and [Yarn](https://yarnpkg.com/).

Run these commands on your terminal:

```bash
git clone git@github.com:fititnt/uwazi-docker.git
cd uwazi-docker
docker-compose up -d elasticsearch mongo
git clone git@github.com:huridocs/uwazi.git
cd uwazi
git checkout 1.1
nvm install 6.13
npm install
yarn production-build
yarn blank-state
yarn reindex
yarn run-production
```

Open your browser at <http://localhost:3000/>. User: _admin_, password: _admin_.

### Customization
Provably will be much easier lean a bit more about
[Docker compose](https://docs.docker.com/compose/overview/) and use the
[docker-compose.yml](docker-compose.yml) as base for your testing or
even for deploying environment than learn, configure and optimize every
part of the stack. But assume that _uwazi-docker_ will try to use small
amount of RAM by default, which means it could run slower even if the Docker
hosts have more RAM available. Consider this as starting point.

Based on your previous skills and experience, you may decide not to use
all stack applications inside docker containers. One example is running
database storages directly on Virtual Machines (or even physical machines)
on the production environment.

### Debug

_Ignore this part if you are not debugging uwazi-docker._

- Run Elastic Search, Mongo, and force rebuild the Dockerfile Uwazi: `docker-compose up --build`
- Login on the running Uwazi container: `docker exec -it uwazidocker_uwazi_1 bash`
- Run only Elastic Search and MongoDB (e.g. if you are running Uwazi without docker): `docker-compose up -d elasticsearch mongo`
- GUI for ElasticSearch (Dejavu) on <http://localhost:51000/>: `docker-compose up -d elasticsearch-gui-dejavu`
- GUI for MongoDB (nosqlclient) on <http://localhost:52000/>: `docker-compose up -d mongo-gui-mongoclient`
- Run all with docker `docker-compose up uwazi`
<!-- - Initialize databases (Run this first time): `docker-compose build` and then `docker-compose run -e IS_FIRST_RUN=true uwazi`-->
<!-- - Run all with docker `docker-compose up uwazi --build` -->


See [how to uninstall](uninstall.md).

## License

[![Public Domain](https://i.creativecommons.org/p/zero/1.0/88x31.png)](UNLICENSE)

To the extent possible under law, [Emerson Rocha](https://github.com/fititnt)
has waived all copyright and related or neighboring rights to this work.
