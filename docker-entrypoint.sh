#!/bin/sh

echo "IS_FIRST_RUN: $IS_FIRST_RUN"

if [ "$IS_FIRST_RUN" = "true" ] ; then
    echo "Enviroment variable IS_FIRST_RUN is true. Assuming need to install database from blank state"
    # echo "Sorry, this version of uwazi-docker is not ready to initialize using docker. You need to setup first time from your host before use this container"
    echo "Sorry, this version of uwazi-docker is not fully ready to initialize using docker. You need to setup the MongoDB outside this container with yarn blank-state"
    # yarn blank-state
    echo "Applyng yarn reindex. This will use data from MongoDB to feed Elastic Search"
    yarn reindex
else
    echo "Data detected. No need to install. Running container."
fi

yarn run-production