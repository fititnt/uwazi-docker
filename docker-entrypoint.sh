#!/bin/sh

# TODO: check for real that data from Mongo & Elastic Search does not exist (fititnt, 2018-04-15 99:22 BRT)
IS_FIRST_RUN=1


if [$IS_FIRST_RUN = 1]; then
  echo "No data detected. Assuming need to install database from blank state"
  yarn blank-state
  yarn reindex
else
  echo "Data detected. No need to install. Running container."
fi

yarn run-production