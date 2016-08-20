#!/bin/bash

# point to the swarm manager
eval "$(docker-machine env --swarm bravo)"

docker info

echo Removing hello world containers
docker-compose --file compose/hello-world.yml down --remove-orphans

echo Scale containers via Docker Compose
CMD="docker-compose --file compose/hello-world-scale.yml scale hello-world=3"
echo $CMD
$CMD

echo Displaying status of the containers in the cluster
docker ps
