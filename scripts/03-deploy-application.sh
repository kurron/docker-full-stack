#!/bin/bash

# point to the swarm manager
eval "$(docker-machine env --swarm bravo)"

echo Removing hello world containers
docker-compose --file compose/hello-world.yml down --remove-orphans

echo Displaying status of the containers in the cluster
docker ps

