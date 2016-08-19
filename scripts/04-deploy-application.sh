#!/bin/bash

# point to the swarm manager
eval "$(docker-machine env --swarm bravo)"

echo Removing hello world containers
ONE="docker-compose --file compose/hello-world-scale.yml down --remove-orphans"
echo $ONE
$ONE

echo Displaying status of the containers in the cluster
docker ps

