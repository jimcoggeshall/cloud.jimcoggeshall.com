#!/bin/bash

docker-compose build
docker-compose up -d
./dp.sh
./wsj.sh
./sdut.sh
./lat.sh
./combine.sh
