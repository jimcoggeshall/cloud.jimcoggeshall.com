#!/bin/bash

mkdir -p var/output && chmod -R 777 var/output
rm -rf var/wsj
mkdir -p var/wsj/output && chmod -R 777 var/wsj/output
docker build -t wsj:latest -f Dockerfile.wsj .
docker run --shm-size='2gb' --network="host" -v $(pwd)/var/wsj/output:/output --rm wsj:latest
cp $(pwd)/var/wsj/output/latest.pdf $(pwd)/var/output/wsj.pdf
