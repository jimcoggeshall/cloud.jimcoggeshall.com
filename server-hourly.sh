#!/bin/bash

docker-compose down
yes | docker system prune -a
docker-compose up --build -d
./wsj.sh
./sdut.sh
./lat.sh
./combine.sh
