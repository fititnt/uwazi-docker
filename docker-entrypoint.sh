#!/bin/sh

echo "IS_FIRST_RUN: $IS_FIRST_RUN"
DB_INITIALIZATION_PATH=/home/node/uwazi/blank_state/uwazi_development

if [ "$IS_FIRST_RUN" = "true" ] ; then
    echo "Enviroment variable IS_FIRST_RUN is true. Assuming need to install database from blank state"
    # echo "Sorry, this version of uwazi-docker is not ready to initialize using docker. You need to setup first time from your host before use this container"
    # echo "Sorry, this version of uwazi-docker is not fully ready to initialize using docker. You need to setup the MongoDB outside this container with yarn blank-state"

    # mongo --version
    # mongorestore --version
    # yarn blank-state

    echo "\n\nDeleting ${DBHOST:-mongo} ${DATABASE_NAME:-uwazi_development} MongoDB database"

    mongo -host ${DBHOST:-mongo} ${DATABASE_NAME:-uwazi_development} --eval "db.dropDatabase()"

    echo "\n\nImporting $DB_INITIALIZATION_PATH to ${DBHOST:-mongo} ${DATABASE_NAME:-uwazi_development} MongoDB database"

    mongorestore -h ${DBHOST:-mongo} $DB_INITIALIZATION_PATH --db=${DATABASE_NAME:-uwazi_development}

    echo "Applyng yarn reindex. This will use data from MongoDB to feed Elastic Search"
    yarn reindex
else
    echo "Enviroment variable IS_FIRST_RUN is not true. Assume MongoDB and Elastic Search provide already are intialized"
    echo "If this is the first time and you want this container also initialize MongoDB and Elastic Search, run only ONE, and just ONE time, with variable IS_FIRST_RUN=true"
fi

yarn run-production