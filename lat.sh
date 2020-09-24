#!/bin/bash

mkdir -p var/output && chmod -R 777 var/output
rm -rf var/lat
mkdir -p var/lat/output && chmod -R 777 var/lat/output
docker build -t lat:latest -f Dockerfile.lat .
docker run --shm-size='2gb' --network="host" -v $(pwd)/var/lat/output:/output --rm lat:latest
cp $(pwd)/var/lat/output/latest.pdf $(pwd)/var/output/lat.pdf
