#!/bin/bash

echo Deploying a constrained service
docker-machine ssh bravo sudo docker service create --mode replicated \
                                                    --replicas=3 \
                                                    --name hello-constrained \
                                                    --constraint 'node.role==worker' \
                                                    alpine ping docker.com

echo Inspect the service
docker-machine ssh bravo sudo docker service inspect --pretty hello-constrained

echo List the logical status of the constrained service
docker-machine ssh bravo sudo docker service ls

echo List where the service is running
watch 'docker-machine ssh bravo sudo docker service ps hello-constrained'

