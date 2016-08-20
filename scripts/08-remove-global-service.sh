#!/bin/bash

echo Removing the global service
docker-machine ssh bravo sudo docker service rm hello-global

echo List the logical status of the global service
docker-machine ssh bravo sudo docker service ls

