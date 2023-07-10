#!/bin/bash
DB_INITIALIZATION_PATH="${DB_INITIALIZATION_PATH:-"/home/node/uwazi/dump/uwazi_development"}"

echo "uwazi-docker: UWAZI_GIT_RELEASE_REF: $UWAZI_GIT_RELEASE_REF"
echo "uwazi-docker: IS_FIRST_RUN: $IS_FIRST_RUN"
echo "uwazi-docker: RUN_YARN_MIGRATE_REINDEX: $RUN_YARN_MIGRATE_REINDEX"
echo "uwazi-docker: DB_INITIALIZATION_PATH: $DB_INITIALIZATION_PATH"
# DB_INITIALIZATION_PATH=/home/node/uwazi/blank_state/uwazi_development

# set -x
# ls -lha /home/node/uwazi/
# ls -lha /home/node/uwazi/dump

if [ "$IS_FIRST_RUN" = "true" ] ; then
    echo "uwazi-docker: Enviroment variable IS_FIRST_RUN is true. Assuming need to install database from blank state"

    echo "uwazi-docker: Deleting ${DBHOST:-mongo} ${DATABASE_NAME:-uwazi_development} MongoDB database"
    # mongo -host ${DBHOST:-mongo} ${DATABASE_NAME:-uwazi_development} --eval "db.dropDatabase()"
    mongosh -host "${DBHOST:-mongo}" "${DATABASE_NAME:-uwazi_development}" --eval "db.dropDatabase()"

    echo "uwazi-docker: Importing $DB_INITIALIZATION_PATH to ${DBHOST:-mongo} ${DATABASE_NAME:-uwazi_development} MongoDB database"
    mongorestore -h "${DBHOST:-mongo}" "$DB_INITIALIZATION_PATH" --db="${DATABASE_NAME:-uwazi_development}"

    echo "uwazi-docker: Applyng yarn reindex. This will use data from MongoDB to feed Elastic Search"
    # yarn reindex
    yarn migrate
    yarn reindex

    echo "uwazi-docker: If no fatal errors occurred, you will never need to use this command again"
    exit 0

elif [ "$RUN_YARN_MIGRATE_REINDEX" = "true" ] ; then
    echo "uwazi-docker: Applyng yarn reindex. This will use data from MongoDB to feed Elastic Search"
    yarn migrate
    yarn reindex

    echo "uwazi-docker: If no fatal errors occurred, you will not need to use this command again unless data needs update to run with newer Uwazi or database version"
    exit 0
else
    echo "uwazi-docker: Enviroment variable IS_FIRST_RUN/RUN_YARN_MIGRATE_REINDEX are not true."
    echo "uwazi-docker: Assume MongoDB and Elastic Search provide already are intialized."
    echo "uwazi-docker: [protip] is possible to initialize (or reset o initial state) MongoDB and Elastic Search with enviroment variable IS_FIRST_RUN=true"
fi

yarn run-production