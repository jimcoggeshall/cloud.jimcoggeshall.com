#!/bin/bash

docker-compose down --remove-orphans
yes | docker system prune -a
docker-compose up --build -d
