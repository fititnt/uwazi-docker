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

Open your browser at <http://localhost:3000/>.

### Customization
Provably will be much easier lean a bit more about
[Docker compose](https://docs.docker.com/compose/overview/) and use the
[docker-compose.yml](docker-compose.yml) as base for your testing or
even for deploying environment than learn, configure and optimize every
part of the stack. But assume that _uwazi-docker_ will try to use small
amount of RAM by default, which means it could run slower even if the Docker
hosts have more RAM available. Consider this as starting point.

Another point that you may consider is that if you believe you are more
practical with your previous skills and experience, you may decide not to use
all stack applications inside docker containers. One example is running
database storages directly on Virtual Machines (or even physical machines)
on the production environment.

### Debug

_Ignore this part if you are not debbuging uwazi-docker._

- Run Elastic Search, Mongo, and force rebuild the Dockerfile Uwazi: `docker-compose up --build`
- Login on the running Uwazi container: `docker exec -it uwazidocker_uwazi_1 bash`
- Run only Elastic Search and MongoDB (e.g. if you are running Uwazi without docker): `docker-compose up -d elasticsearch mongo`
- GUI for ElasticSearch (Dejavu) on <http://localhost:51000/>: `docker-compose up -d elasticsearch-gui-dejavu`
- GUI for MongoDB (nosqlclient) on <http://localhost:52000/>: `docker-compose up -d mongo-gui-mongoclient`


<!--

git clone git@github.com:huridocs/uwazi.git
cd uwazi
## You need NVM installed, see https://github.com/creationix/nvm
nvm install 6.13
npm install
## You need Yarn installed, see https://yarnpkg.com/
yarn production-build
yarn blank-state
yarn run-production

# Open browser on http://127.0.0.1:3000/

## Still not work. Getting this error
```bash
{ error: 
      [ '[index_not_found_exception] no such index, with { resource.type="index_or_alias" & resource.id="uwazi_development" & index_uuid="_na_" & index="uwazi_development" } :: {"path":"/uwazi_development/_search","query":{},"body":"{\\"_source\\":{\\"include\\":[\\"title\\",\\"icon\\",\\"processed\\",\\"creationDate\\",\\"template\\",\\"metadata\\",\\"type\\",\\"sharedId\\",\\"toc\\",\\"attachments\\",\\"language\\",\\"file\\",\\"uploaded\\",\\"published\\",\\"relationships\\"]},\\"from\\":0,\\"size\\":30,\\"query\\":{\\"bool\\":{\\"must\\":[{\\"bool\\":{\\"should\\":[]}}],\\"must_not\\":[],\\"filter\\":[{\\"term\\":{\\"published\\":true}},{\\"term\\":{\\"language\\":\\"en\\"}}]}},\\"sort\\":[{\\"creationDate.sort\\":{\\"order\\":\\"desc\\",\\"unmapped_type\\":\\"boolean\\"}}],\\"aggregations\\":{\\"all\\":{\\"global\\":{},\\"aggregations\\":{\\"types\\":{\\"terms\\":{\\"field\\":\\"template.raw\\",\\"missing\\":\\"missing\\",\\"size\\":9999},\\"aggregations\\":{\\"filtered\\":{\\"filter\\":{\\"bool\\":{\\"must\\":[{\\"bool\\":{\\"should\\":[]}},{\\"term\\":{\\"language\\":\\"en\\"}}],\\"filter\\":[{\\"match\\":{\\"published\\":true}}]}}}}}}}}}","statusCode":404,"response":"{\\"error\\":{\\"root_cause\\":[{\\"type\\":\\"index_not_found_exception\\",\\"reason\\":\\"no such index\\",\\"resource.type\\":\\"index_or_alias\\",\\"resource.id\\":\\"uwazi_development\\",\\"index_uuid\\":\\"_na_\\",\\"index\\":\\"uwazi_development\\"}],\\"type\\":\\"index_not_found_exception\\",\\"reason\\":\\"no such index\\",\\"resource.type\\":\\"index_or_alias\\",\\"resource.id\\":\\"uwazi_development\\",\\"index_uuid\\":\\"_na_\\",\\"index\\":\\"uwazi_development\\"},\\"status\\":404}"}',
        '    at respond (/alligo/code/fititnt/uwazi-docker/uwazi/node_modules/elasticsearch/src/lib/transport.js:295:15)',
        '    at checkRespForFailure (/alligo/code/fititnt/uwazi-docker/uwazi/node_modules/elasticsearch/src/lib/transport.js:254:7)',
        '    at HttpConnector.<anonymous> (/alligo/code/fititnt/uwazi-docker/uwazi/node_modules/elasticsearch/src/lib/connectors/http.js:159:7)',
        '    at IncomingMessage.bound (/alligo/code/fititnt/uwazi-docker/uwazi/node_modules/elasticsearch/node_modules/lodash/dist/lodash.js:729:21)',
        '    at emitNone (events.js:91:20)',
        '    at IncomingMessage.emit (events.js:185:7)',
        '    at endReadableNT (_stream_readable.js:974:12)',
        '    at _combinedTickCallback (internal/process/next_tick.js:80:11)',
        '    at process._tickCallback (internal/process/next_tick.js:104:9)' ] },
  status: 500 }
    at /alligo/code/fititnt/uwazi-docker/uwazi/app/react/ServerRouter.js:184:15
    at process._tickCallback (internal/process/next_tick.js:109:7)
```

yarn reindex
yarn run-production
# http://127.0.0.1:3000/ Shows "Uwazi To start you need to create some templates in settings"

-->

See [how to uninstall](uninstall.md).

## License

[![Public Domain](https://i.creativecommons.org/p/zero/1.0/88x31.png)](UNLICENSE)

To the extent possible under law, [Emerson Rocha](https://github.com/fititnt)
has waived all copyright and related or neighboring rights to this work.
