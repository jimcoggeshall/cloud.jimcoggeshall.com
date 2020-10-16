#!/bin/bash

docker-compose down
yes | docker system prune -a --remove-orphans
docker-compose up --build -d
