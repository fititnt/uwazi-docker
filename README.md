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

### Install
Run these commands on your terminal:

```bash
git clone git@github.com:fititnt/uwazi-docker.git
cd uwazi-docker
docker-compose run -e IS_FIRST_RUN=true --rm uwazi

```
<!-- docker-compose run --rm uwazi-installer -->

### Run

```bash
docker-compose up -d uwazi
```

Open your browser at <http://localhost:3000/>. User: _admin_, password: _admin_.

### Basic docker commands

```bash
# Stop all containers from this uwazi-docker and do not restart again until you explicit ask for it
docker-compose stop

# Using "-d" param to run uwazi and its dependencies on background
docker-compose up -d uwazi

# No "-d" param, start uwazi, MongoDB & Elastic Search and see what is happening inside the containers
docker-compose up uwazi

# See what containers are running now
docker ps

# Want some GUI to see what is happening on MongoDB? Use nosqlclient
docker-compose up -d mongo-gui-mongoclient

# Want some GUI to see what is happening on Elastic Search? Try Dejavu
docker-compose up -d mongo-gui-mongoclient
```

### Extra features

#### Want some GUI to see what is happening on MongoDB? Use nosqlclient

```bash
docker-compose up -d mongo-gui-mongoclient
```

By default, uses <http://localhost:51000/>.

#### Want some GUI to see what is happening on Elastic Search? Try Dejavu

```bash
docker-compose up -d elasticsearch-gui-dejavu
```

By default, uses <http://localhost:52000/>.

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

### Uninstall

See [how to uninstall](uninstall.md).

## License

[![Public Domain](https://i.creativecommons.org/p/zero/1.0/88x31.png)](UNLICENSE)

To the extent possible under law, [Emerson Rocha](https://github.com/fititnt)
has waived all copyright and related or neighboring rights to this work to
[Public Domain](UNLICENSE).

Optionally, you can choose to use the [MIT License](DUAL-LICENSE-MIT.md) instead
of Public Domain unlicense.