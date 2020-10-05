#!/bin/bash

docker-compose build
docker-compose up -d
#./wsj.sh
./sdut.sh
./lat.sh
./combine.sh
