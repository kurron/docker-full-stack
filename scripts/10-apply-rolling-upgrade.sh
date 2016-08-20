#!/bin/bash

echo Upgrade to a newer version of the container
docker-machine ssh bravo sudo docker service update --image redis:3.0.7 redis

echo Inspect the service
docker-machine ssh bravo sudo docker service inspect --pretty redis

echo Monitor the transition between versions
watch 'docker-machine ssh bravo sudo docker service ps redis'

