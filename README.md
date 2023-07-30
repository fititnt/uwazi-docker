# Uwazi with Docker
This work-in-progress repository allows you to run the
[Uwazi](http://www.uwazi.io) using [Docker containers](https://docker.com). It
can be a good alternative if you are testing the software and have no
proficiency with the entire stack of applications involved.

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
The uwazi-docker requires docker compose installed. See
[requirements](requirements.md). If you are a developer, can also check some
advanced information on [development-instructions.md](development-instructions.md)
and a draft of [production-instructions.md](production-instructions.md).

### Install
Run these commands on your terminal **only** the first time:

```bash
git clone https://github.com/fititnt/uwazi-docker.git
cd uwazi-docker
docker compose run -e IS_FIRST_RUN=true --rm uwazi # Install without sample data
# docker compose run -e IS_FIRST_DEMO_RUN=true --rm uwazi # Install with sample data
```

With very fast internet and disks, this step will take between 8 to 15 minutes.
The `IS_FIRST_DEMO_RUN=true` is an alternative that starts with test/example data.

<details>
<summary>(Advanced) All initialization options with default values</summary>

Uwazi docker fetch data from git, and a very specific release (UWAZI_GIT_RELEASE_REF defaults to tag production, but this likely eventually will require upgrade uwazi-docker itself) and initialize with empty database (DB_INITIALIZATION_PATH, but you may want to change for a example test database, or even upstream might change path in the future).

With this in mind, the default values might need updates (which in this case please open an issue and report the problem) but in the meantime you can just change the options.

<pre>
git clone https://github.com/fititnt/uwazi-docker.git
cd uwazi-docker
docker compose run -e IS_FIRST_RUN=true -e UWAZI_GIT_RELEASE_REF=production -e DB_INITIALIZATION_PATH=/home/node/uwazi/database/blank_state/uwazi_development --rm uwazi
</pre>
</details>

### Run

```bash
# Run uwazi on background (automatic restart on reboot unless stopped)
docker compose up -d uwazi
```

Open your browser at <http://localhost:3000/>. Initial user: `admin`, password: `change this password now`.
(or if using `IS_FIRST_DEMO_RUN=true`, user: `admin`, password: `admin`).

#### `yarn migrate` and `yarn reindex`

At installation step the `yarn migrate` and `yarn reindex` are always executed,
however the database will be erased to a blank state.
However, if for some you already have real data and not major database upgrade,
in which MongoDB and ElasticSearch might need some minor custom steps outside of Uwazi control,
this command will run once only the `yarn migrate` and `yarn reindex`.

```bash
docker compose run -e RUN_YARN_MIGRATE_REINDEX=true --rm uwazi
```

Just to be sure, if working with real data, **please backup the volumes first**.

### Basic docker commands

```bash
# Stop all containers from this uwazi-docker and do not restart again until you explicit ask for it
docker compose stop

# Using "-d" param to run uwazi and its dependencies on background
docker compose up -d uwazi

# No "-d" param, start uwazi, MongoDB & Elastic Search and see what is happening inside the containers
docker compose up uwazi

# See what containers are running now
docker ps

# See all docker volumes
docker volume ls

# See docker volumes that stores data from uwazi-docker (hint: these ones to backup & restore)
docker volume ls | grep 'mongodb_data1\|uploaded_documents'

# Want some GUI to see what is happening on MongoDB? Use nosqlclient
docker compose up -d mongo-gui-mongoclient

# Want some GUI to see what is happening on Elastic Search? Try Dejavu
docker compose up -d elasticsearch-gui-dejavu
```

### Extra features

#### Want some GUI to see what is happening on MongoDB? Use nosqlclient

```bash
docker compose up -d mongo-gui-mongoclient
```

By default, uses <http://localhost:51000/>.

#### Want some GUI to see what is happening on Elastic Search? Try Dejavu

```bash
docker compose up -d elasticsearch-gui-dejavu
```

By default, uses <http://localhost:52000/>.

### Uninstall

See [how to uninstall](uninstall.md).

## License

[![Public Domain](https://i.creativecommons.org/p/zero/1.0/88x31.png)](UNLICENSE)

To the extent possible under law, [Emerson Rocha](https://github.com/fititnt)
has waived all copyright and related or neighboring rights to this work to
[Public Domain](UNLICENSE).

Optionally, you can choose to use the [MIT License](https://opensource.org/licenses/MIT)
instead of Public Domain unlicense.

<!--

docker compose --file docker compose.yml run -e IS_FIRST_RUN=true --rm uwazi
# (...)
docker stop $(docker ps -a -q)
docker system prune --all
docker volume prune

# debug containers
docker ps
docker logs --tail 50 --follow --timestamps uwazi-docker-mongo-1
docker logs --tail 50 --follow --timestamps uwazi-docker-elasticsearch-1


###
git clone -b production --single-branch --depth=1 https://github.com/huridocs/uwazi.git huridocs-uwazi-docker/

-->