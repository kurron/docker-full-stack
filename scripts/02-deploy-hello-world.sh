#!/bin/bash

ONE="docker run --detach \
                --name=hello-one \
                --net=none \
                dockercloud/hello-world:latest"

TWO="docker run --detach \
                --name=hello-two \
                --net=none \
                dockercloud/hello-world:latest"

# point to the swarm manager
$(docker-machine env --swarm bravo)
eval "$(docker-machine env --swarm bravo)"

docker info

echo Deploying the first container
$ONE

echo Deploying the second container
$TWO

echo Displaying status of the containers in the cluster
docker ps
