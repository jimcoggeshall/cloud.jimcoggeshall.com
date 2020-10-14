#!/bin/bash

mkdir -p var/output && chmod -R 777 var/output
rm -rf var/dp
mkdir -p var/dp/output && chmod -R 777 var/dp/output
docker build -t dp:latest -f Dockerfile.dp .
docker run --shm-size='2gb' --network="host" -v $(pwd)/var/dp/output:/output --rm dp:latest
cp $(pwd)/var/dp/output/latest.pdf $(pwd)/var/output/dp.pdf
