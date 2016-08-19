#!/bin/bash

# point to the swarm manager
eval "$(docker-machine env --swarm bravo)"

docker info

echo Creating overlay network for the application containers
ONE="docker network create --driver overlay showcase"
echo $ONE
$TWO
docker network ls

echo Deploy containers via Docker Compose
TWO="docker-compose --file compose/hello-world.yml up -d"
echo $TWO
$TWO

echo Displaying status of the containers in the cluster
docker ps
