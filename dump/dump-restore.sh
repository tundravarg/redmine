#!/bin/bash

FILE=$1

if [[ ! -f $FILE ]]; then
    echo Dump file \"$FILE\" does not exist
    exit 1
fi

echo -n DB password:
read -s password
echo
export PGPASSWORD=$password

psql -h localhost -U postgres -c 'DROP DATABASE IF EXISTS redmine;' &&
psql -h localhost -U postgres -c 'CREATE DATABASE redmine WITH ENCODING='UTF8' OWNER=redmine;' &&
psql -h localhost -U postgres -d redmine -v ON_ERROR_STOP=1 -f $FILE &&

echo DONE || ( echo FAIL; exit 1; )
