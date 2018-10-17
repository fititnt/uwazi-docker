# Use of Uwazi in production environment
<!--
> Disclaimer: [uwazi-docker](https://github.com/fititnt/uwazi-docker) can make it
easy for someone unskilled test [Uwazi](https://www.uwazi.io/) and, at best,
in hands with someone with a knowledge of docker/databases and free time, be a
reference base to use for a small deployment **at your own risk**. The Uwazi
itself (the software, without the full stack with Mongodb and ElasticSearch on
this dockerized version) are production-ready, safe to use on your organization.
-->

## SaaS
Software as a service is offered in <https://www.uwazi.io/>.

## On your server (Uwazi oficial documentation)

Please look at the oficial documentation at huridocs/uwazi Wiki on
<https://github.com/huridocs/uwazi/wiki/Install-Uwazi-on-your-server>.

## With uwazi-docker
> In short: **uwazi-docker is not designed to run in production**. If in the
future enough volunteers with both experience and usage on production
environment feel more confident, this status could change. Follow these
instructions **at your own risk**. Suggestions are welcome.

### Where is my data?
Your data is stored on [docker volumes](https://docs.docker.com/storage/volumes/).
Each volume can be attached to only one active container. The most reliable way
to backup is take snapshot of all data containers at same time, so consider this
when doing a backup in a active moment of your application.

The data volumes (and sources of data if you are using Uwazi without docker)
that contain real data that cannot be recreated are:

- **MongoDB database**
- **uploaded_documents folder**
- _Elastic Search database_ (Cache that needs to be recreated)

> You can backup and restore the Elastic Search database, but since is possible
to recreate it's indexes by running `yarn reindex` from a non-dockerized
uwazi or a uwazi-docker dockerised uwazi service, it is basic a cache for search.
**At this current version uwazi-docker does not automate `yarn reindex`, so
you would need to use [docker exec](https://docs.docker.com/engine/reference/commandline/exec/)
to do it once after restore a backup.**


To see the names of the docker volumes, use this command:

```sh
docker volume ls | grep 'mongodb_data1\|uploaded_documents'
```

### How to backup docker volumes

See docker official documentation on [Backup, restore, or migrate data volumes](https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes).
This link also shows how to move data from docker volume to your host
filesystem.

See [blacklabelops/volumerize](https://github.com/blacklabelops/volumerize) for
a powerfull automated solution for periodic backups.

----

_Did you have extra tips or improvements that could make uwazi-docker a bit more
friendly to run on production but still be able to be tested for unskilled
people? If you are willing to release your collaboration under public domain,
you can submit suggestions in <https://github.com/fititnt/uwazi-docker/issues>._
