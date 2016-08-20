#!/bin/bash

# IMPORTANT: As of Docker 1.12.0, Swarm is built into Docker.  Be careful not to confuse or mix
# instructions that use the older container-based Swarm with the new stuff.  They are incompatible!

export GENERIC_ENGINE_PORT=2376
export GENERIC_SSH_USER=vagrant
export GENERIC_SSH_PORT=22

#################
# Alpha will be the console node
#################
ALPHA_RAW_KEY="/vagrant/.vagrant/machines/alpha/virtualbox/private_key"
ALPHA_SECURE_KEY="/tmp/alpha_key"
cp --verbose ${ALPHA_RAW_KEY} ${ALPHA_SECURE_KEY}
sudo chmod 0400 ${ALPHA_SECURE_KEY}

CMD="docker-machine create --driver generic \
                           --generic-ip-address=10.10.10.10 \
                           --generic-ssh-key ${ALPHA_SECURE_KEY} \
                           --engine-storage-driver overlay \
                           --engine-opt graph=/opt/docker \
                           --engine-label size=small \
                           --engine-label role=console \
                           alpha"
    echo Docker Machine is provisioning alpha at 10.10.10.10 to run Consul
#   echo $CMD
    $CMD


# Install Consul onto Alpha so that cluster participants can register themselves
CONSUL="sudo docker run --detach \
                        --restart=always \
                        --name=consul \
                        --net=host \
                        consul:latest \
                        agent \
                        -server \
                        -bootstrap \
                        -ui \
                        -dc showcase \
                        -bind 10.10.10.10 \
                        -client 10.10.10.10"
echo $CONSUL
$CONSUL

#################
# Bravo will be the Swarm Manager
#################
BRAVO_RAW_KEY="/vagrant/.vagrant/machines/bravo/virtualbox/private_key"
BRAVO_SECURE_KEY="/tmp/bravo_key"
cp --verbose ${BRAVO_RAW_KEY} ${BRAVO_SECURE_KEY}
sudo chmod 0400 ${BRAVO_SECURE_KEY}

CMD="docker-machine create --driver generic \
                           --generic-ip-address=10.10.10.20 \
                           --generic-ssh-key ${BRAVO_SECURE_KEY} \
                           --engine-storage-driver overlay \
                           --engine-opt graph=/opt/docker \
                           --engine-label size=small \
                           --engine-label role=manager \
                           bravo"
    echo Docker Machine is provisioning bravo at 10.10.10.20 to be the Swarm Master 
#   echo $CMD
    $CMD


#################
# Charlie, Delta and Echo will be the Swarm Workers
#################
declare -A hosts

hosts[charlie]=10.10.10.30
hosts[delta]=10.10.10.40
hosts[echo]=10.10.10.50

for c in "${!hosts[@]}"; do
    NAME=$c
    IP=${hosts[$c]}

    RAW_KEY="/vagrant/.vagrant/machines/${NAME}/virtualbox/private_key"
    SECURE_KEY="/tmp/${NAME}_key"
    cp --verbose ${RAW_KEY} ${SECURE_KEY}
    sudo chmod 0400 ${SECURE_KEY}

    CMD="docker-machine create --driver generic \
                               --generic-ip-address=${IP} \
                               --generic-ssh-key ${SECURE_KEY} \
                               --engine-storage-driver overlay \
                               --engine-opt graph=/opt/docker \
                               --engine-label size=medium \
                               --engine-label role=worker \
                               ${NAME}"
    echo Docker Machine is provisioning ${NAME} at ${IP} to be a Swarm Worker
#   echo $CMD
    $CMD
done

echo show the created engines
docker-machine ls

