#!/bin/bash

echo Deploying a constrained service
docker-machine ssh bravo sudo docker service scale hello-constrained=1

echo Inspect the service
docker-machine ssh bravo sudo docker service inspect --pretty hello-constrained

echo List the logical status of the constrained service
docker-machine ssh bravo sudo docker service ls

echo List where the service is running
docker-machine ssh bravo sudo docker service ps hello-constrained
 
