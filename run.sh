#!/bin/sh

# -it - Interactive mode
# -d  - Detached mode

docker run \
    -it \
    -p 5432:5432 \
    -v "$(pwd)/data/postgres:/var/lib/postgresql/13/main" \
    redmine