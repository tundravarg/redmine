#!/bin/sh

# -it - Interactive mode
# -d  - Detached mode
# -v "$(pwd)/data/postgres:/var/lib/postgresql/13/main" \

docker run \
    -it \
    -p 5432:5432 \
    -p 3000:3000 \
    -v "$(pwd)/share:/root/share" \
    redmine