#!/bin/bash

echo Deploying a global service
docker-machine ssh bravo sudo docker service create --mode global --name hello-global alpine ping docker.com

echo List the logical status of the global service
docker-machine ssh bravo sudo docker service ls

echo List the physical status of the global service
docker-machine ssh bravo sudo docker node ps bravo
docker-machine ssh bravo sudo docker node ps charlie
docker-machine ssh bravo sudo docker node ps delta
docker-machine ssh bravo sudo docker node ps echo


