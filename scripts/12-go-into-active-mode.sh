#!/bin/bash

echo Put echo into active mode 
docker-machine ssh bravo sudo docker node update --availability active echo 

echo Inspect the node
docker-machine ssh bravo sudo docker node inspect --pretty echo 

echo Inspect the status of the Swarm
docker-machine ssh bravo sudo docker node ls

