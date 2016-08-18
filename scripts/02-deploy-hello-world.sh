#!/bin/bash

# point to the swarm manager
eval "$(docker-machine env --swarm bravo)"

docker info

echo Creating overlay network for the application containers
docker network create --driver overlay showcase
docker network ls

echo Deploy containers via Docker Compose
docker-compose --file compose/hello-world.yml up -d

echo Displaying status of the containers in the cluster
docker ps
