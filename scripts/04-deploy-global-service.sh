#!/bin/bash

echo Deploying a global service
docker-machine ssh bravo sudo docker service create --mode global --name hello-global alpine ping docker.com

echo Inspect the service
docker-machine ssh bravo sudo docker service inspect --pretty hello-global

echo List the logical status of the global service
docker-machine ssh bravo sudo docker service ls

echo List where the service is running
watch 'docker-machine ssh bravo sudo docker service ps hello-global'

