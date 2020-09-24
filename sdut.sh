#!/bin/bash

mkdir -p var/output && chmod -R 777 var/output
rm -rf var/sdut
mkdir -p var/sdut/output && chmod -R 777 var/sdut/output
docker build -t sdut:latest -f Dockerfile.sdut .
docker run --shm-size='2gb' --network="host" -v $(pwd)/var/sdut/output:/output --rm sdut:latest
cp $(pwd)/var/sdut/output/latest.pdf $(pwd)/var/output/sdut.pdf
