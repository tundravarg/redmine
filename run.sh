#!/bin/sh

# -it - Interactive mode
# -d  - Detached mode
# -v "$(pwd)/data/postgres:/var/lib/postgresql/13/main" \

docker run \
    -d \
    -p 5432:5432 \
    -p 3072:3000 \
    -v "$(pwd)/share:/root/share" \
    -v "$(pwd)/data/postgres:/var/lib/postgresql/13/main" \
    redmine
