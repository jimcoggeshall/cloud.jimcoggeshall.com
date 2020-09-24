#!/bin/bash

yes | docker system prune -a
./sdut.sh
