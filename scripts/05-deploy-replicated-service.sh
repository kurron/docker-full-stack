#!/bin/bash

echo Deploying a replicated service
docker-machine ssh bravo sudo docker service create --mode replicated --replicas=2 --name hello-replicated alpine ping docker.com

echo Inspect the service
docker-machine ssh bravo sudo docker service inspect --pretty hello-replicated

echo List the logical status of the replicated service
docker-machine ssh bravo sudo docker service ls

echo List where the service is running
watch 'docker-machine ssh bravo sudo docker service ps hello-replicated'

