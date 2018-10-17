# Uninstall Uwazi with Docker

These commands explain how to uninstall uwazi-docker.

## Uninstall

Use [docker-compose down](https://docs.docker.com/compose/reference/down/) to
remove the containers and networks created by uwazi-docker. This will not
delete the data created.

`docker-compose down`

## Complete Uninstall

Run these commands on the same directory of uwazi-docker to uninstall the
programs and all content created.

```bash

# Remove containers, networks and volumes created by uwazi-docker docker-compose up
## WARNING! THIS WILL DELETE THE DATABASE AND DOCUMENTS!!!
docker-compose down -v --rmi all --remove-orphans

# data/ folder can contain additional files. If you are using linux, depending
# of how your docker was configured, is possible that some of these need root
# access to be removed.

sudo rm -rf data/*

```