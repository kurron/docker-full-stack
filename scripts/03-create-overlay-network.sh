#!/bin/bash

echo Creating overlay network for the application containers
docker-machine ssh bravo sudo docker network create --driver overlay showcase
docker-machine ssh bravo sudo docker network ls
docker-machine ssh bravo sudo docker network inspect showcase

