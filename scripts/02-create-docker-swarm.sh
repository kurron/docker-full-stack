#!/bin/bash

echo Creating the Swarm, making Bravo the Manager
docker-machine ssh bravo sudo docker swarm init --advertise-addr 10.10.10.20

echo Capture the manager and worker tokens
MANAGER_TOKEN=$(docker-machine ssh bravo sudo docker swarm join-token --quiet manager)
WORKER_TOKEN=$(docker-machine ssh bravo sudo docker swarm join-token --quiet worker)

echo Joining remaining nodes to the Swarm as Workers
docker-machine ssh charlie sudo docker swarm join --token $WORKER_TOKEN 10.10.10.20:2377
docker-machine ssh delta sudo docker swarm join --token $WORKER_TOKEN 10.10.10.20:2377
docker-machine ssh echo sudo docker swarm join --token $WORKER_TOKEN 10.10.10.20:2377

echo List nodes in the Swarm
docker-machine ssh bravo sudo docker node ls
