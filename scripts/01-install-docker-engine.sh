#!/bin/bash

export GENERIC_ENGINE_PORT=2376
export GENERIC_SSH_USER=vagrant
export GENERIC_SSH_PORT=22

# configure Alpha as the master control node
ALPHA_RAW_KEY="/vagrant/.vagrant/machines/alpha/virtualbox/private_key"
ALPHA_SECURE_KEY="/tmp/alpha_key"
cp --verbose ${ALPHA_RAW_KEY} ${ALPHA_SECURE_KEY}
sudo chmod 0400 ${ALPHA_SECURE_KEY}

CMD="docker-machine create --driver generic \
                           --generic-ip-address=10.10.10.10 \
                           --generic-ssh-key ${ALPHA_SECURE_KEY} \
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

# Configure Bravo to be the Swarm Manager
BRAVO_RAW_KEY="/vagrant/.vagrant/machines/bravo/virtualbox/private_key"
BRAVO_SECURE_KEY="/tmp/bravo_key"
cp --verbose ${BRAVO_RAW_KEY} ${BRAVO_SECURE_KEY}
sudo chmod 0400 ${BRAVO_SECURE_KEY}

CMD="docker-machine create --driver generic \
                           --generic-ip-address=10.10.10.20 \
                           --generic-ssh-key ${BRAVO_SECURE_KEY} \
                           --swarm \
                           --swarm-master \
                           --swarm-addr 10.10.10.20 \
                           --swarm-discovery consul://10.10.10.10:8500 \
                           bravo"
    echo Docker Machine is provisioning bravo at 10.10.10.20 to be the Swarm Master 
#   echo $CMD
    $CMD


# Configure Charlie and Delta to be the Swarm Nodes
declare -A hosts

hosts[charlie]=10.10.10.30
hosts[delta]=10.10.10.40

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
                               --swarm \
                               --swarm-host tcp://10.10.10.20:3376 \
                               --swarm-discovery consul://10.10.10.10:8500 \
                               ${NAME}"
    echo Docker Machine is provisioning ${NAME} at ${IP} to be a Swarm Slave
#   echo $CMD
    $CMD
done

echo show the created engines
docker-machine ls

echo Display the cluster information by connecting to bravo
eval "$(docker-machine env --swarm bravo)"
docker info

