# Upgrade instructions
> **Attention: always make a full backup before upgrading from an older version
to a new one of Uwazi software.** Tip: the most important parts are MongoDB
database and the uploaded_documents

<s>At the moment, uwazi-docker has commands that facilitate the first installation
of the software, but</s> upgrades from an old version of uwazi to a new one that
involve updating the database **require following official uwazi documentation**.

- See: Upgrading Uwazi and data migrations at <https://github.com/huridocs/uwazi#upgrading-uwazi-and-data-migrations>.

Tip: see docker exec documentation at <https://docs.docker.com/engine/reference/commandline/exec/>
to undestand how to run commands inside the container that runs the uwazi and
run the commands that both update database and documents from older to the
new version.

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

#### Major upgrade of MongoDB
Please check MongoDB documentation.

Please also open an issue on this repository if the way uwazi-docker run with newer MongoDB need changes. This was the case with last MongoDB upgrade (need some googling to replace the parameters, not hard).

#### Major upgrade of ElasticSearch
Please check ElasticSearch documentation and report issues here.
