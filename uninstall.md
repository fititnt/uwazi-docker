# Uninstall Uwazi with Docker

These commands explain how to uninstall uwazi-docker.

## Uninstall

Use [docker-compose down](https://docs.docker.com/compose/reference/down/) to
remove the containers and networks created by uwazi-docker. This will not
delete the data created.

`docker-compose down # clean only containers and networks`

## Complete Uninstall

Run these commands on the same directory of uwazi-docker to uninstall the
programs and all content created. A recommended way if you plan do not use
more the uwazi-docker or want a really full reinstall (e.g. is debugging).

**WARNING! THIS WILL DELETE THE DATABASE AND DOCUMENTS!!!**

```bash

# Remove containers, networks and volumes created by uwazi-docker docker-compose up
docker-compose down -v --rmi all --remove-orphans # WARNING: Purge everything, even data
```