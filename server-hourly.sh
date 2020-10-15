#!/bin/bash

docker-compose build
./dp.sh
./wsj.sh
./sdut.sh
./lat.sh
./combine.sh
