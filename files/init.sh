#!/bin/bash

echo "Setup postgres data" &&
chown -R postgres /var/lib/postgresql/13/main &&
chgrp -R postgres /var/lib/postgresql/13/main &&
chmod -R 0750 /var/lib/postgresql/13/main &&

service postgresql start &&

echo STARTED && bash || echo FAIL
