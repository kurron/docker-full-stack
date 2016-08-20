#!/bin/bash

echo Install Busybox
docker-machine ssh bravo sudo docker service create --mode replicated \
                                                    --replicas 1 \
                                                    --name busybox \
                                                    --update-delay 10s \
                                                    --network showcase \
                                                    busybox:latest sleep 3000

echo Inspect the service
docker-machine ssh bravo sudo docker service inspect --pretty busybox

echo List the logical status of the replicated service
docker-machine ssh bravo sudo docker service ls

echo List where the service is running
watch 'docker-machine ssh bravo sudo docker service ps busybox'

