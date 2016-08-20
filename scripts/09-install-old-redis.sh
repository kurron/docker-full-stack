#!/bin/bash

echo Install an "old" version of the container
docker-machine ssh bravo sudo docker service create --mode replicated \
                                                    --replicas 4 \
                                                    --name redis \
                                                    --update-delay 10s \
                                                    --network showcase \
                                                    redis:3.0.6

echo Inspect the service
docker-machine ssh bravo sudo docker service inspect --pretty redis

echo List the logical status of the replicated service
docker-machine ssh bravo sudo docker service ls

echo List where the service is running
watch 'docker-machine ssh bravo sudo docker service ps redis'

