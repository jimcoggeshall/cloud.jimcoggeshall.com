#!/bin/bash

yes | docker system prune -a
docker-compose build --pull
docker-compose restart
docker-compose up -d
./wsj.sh
./sdut.sh
./lat.sh
./combine.sh
