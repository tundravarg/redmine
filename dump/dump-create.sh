#!/bin/bash

DIR=dumps
FILE=redmine-$(date +%Y%m%d-%H%M%S).sql

mkdir -p $DIR
pg_dump -h localhost -U postgres -d redmine -f $DIR/$FILE
