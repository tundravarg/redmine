#!/bin/bash

bundle exec rails server -u webrick -e production &&
echo 'DONE' || ( echo 'FAIL'; exit 1; )