#!/bin/bash

echo Deploying a constrained service
docker-machine ssh bravo sudo docker service create --mode replicated \
                                                    --replicas=3 \
                                                    --name hello-constrained \
                                                    --constraint 'node.role==worker' \
                                                    alpine ping docker.com

echo List the logical status of the constrained service
docker-machine ssh bravo sudo docker service ls

echo List the physical status of the constrained service
docker-machine ssh bravo sudo docker node ps bravo
docker-machine ssh bravo sudo docker node ps charlie
docker-machine ssh bravo sudo docker node ps delta
docker-machine ssh bravo sudo docker node ps echo


