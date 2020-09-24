#!/bin/bash

mkdir -p var/output && chmod -R 777 var/output
docker build -t sdut:latest -f Dockerfile.sdut .
docker run --shm-size='2gb' --network="host" -v $(pwd)/var/output:/output --rm sdut:latest
cp $(pwd)/var/output/latest.pdf $(pwd)/var/www/cloud.jimcoggeshall.com/TodaysPapaer.pdf
