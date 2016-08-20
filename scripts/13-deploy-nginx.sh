#!/bin/bash

echo Install Nginx 
docker-machine ssh bravo sudo docker service create --mode replicated \
                                                    --replicas 3 \
                                                    --name nginx \
                                                    --update-delay 10s \
                                                    --network showcase \
                                                    --endpoint-mode dnsrr \
                                                    nginx:latest

echo Inspect the service
docker-machine ssh bravo sudo docker service inspect --pretty nginx

echo List the logical status of the replicated service
docker-machine ssh bravo sudo docker service ls

echo List where the service is running
watch 'docker-machine ssh bravo sudo docker service ps nginx'

