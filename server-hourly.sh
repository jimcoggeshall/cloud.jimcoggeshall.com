#!/bin/bash

yes | docker system prune
docker-compose build
docker-compose restart
docker-compose up -d
./wsj.sh
./sdut.sh
./lat.sh
./combine.sh
