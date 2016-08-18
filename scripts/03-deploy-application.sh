#!/bin/bash

ONE="docker rm --force hello-one"
TWO="docker rm --force hello-two"
THREE="docker rm --force hello-three"

# point to the swarm manager
eval "$(docker-machine env --swarm bravo)"

echo Removing the first container
$ONE

echo Removing the second container
$TWO

echo Removing the third container
$THREE

echo Displaying status of the containers in the cluster
docker ps

echo Creating overlay network for the application containers
docker network create --driver overlay --subnet 192.168.50.50/24 showcase
docker network ls
