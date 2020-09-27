#!/bin/bash

mkdir -p var/output && chmod -R 777 var/output
docker build -t combine:latest -f Dockerfile.combine .
docker run --shm-size='2gb' --network="host" -v $(pwd)/var/output:/output --rm combine:latest
find $(pwd)/var/output -name '*.pdf' |\
while read f; do
    cp "$f" "$(pwd)/var/www/cloud.jimcoggeshall.com/"
done
