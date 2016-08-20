#!/bin/bash

echo Put echo into maintenance mode 
docker-machine ssh bravo sudo docker node update --availability drain echo

echo Inspect the node
docker-machine ssh bravo sudo docker node inspect --pretty echo

echo Inspect the status of the Swarm
docker-machine ssh bravo sudo docker node ls

echo Monitor the transition between versions
watch 'docker-machine ssh bravo sudo docker service ps redis'

