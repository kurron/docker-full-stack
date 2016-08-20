#!/bin/bash

echo Deploying a replicated service
docker-machine ssh bravo sudo docker service create --mode replicated --replicas=2 --name hello-replicated alpine ping docker.com

echo List the logical status of the replicated service
docker-machine ssh bravo sudo docker service ls

echo List the physical status of the replicated service
docker-machine ssh bravo sudo docker node ps bravo
docker-machine ssh bravo sudo docker node ps charlie
docker-machine ssh bravo sudo docker node ps delta
docker-machine ssh bravo sudo docker node ps echo


