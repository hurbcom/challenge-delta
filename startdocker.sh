#!/bin/bash

#Instalando Docker
if [[ $(which docker) ]]; then
    echo "Docker Instalado"
    
  else
    echo "Instalando Docker"
    curl -fsSL https://get.docker.com | bash 
fi

#Ativa Buildkit para utilizar secrets

export DOCKER_BUILDKIT=1

#Cria rede para comunicação dos containers
if [[ $(docker network ls | grep delta) ]]; then
    echo "Rede delta já existe"

  else
    echo "Criando rede delta"
    docker network create -d bridge delta
fi


#Faz o build das imagens
cd ./db_delta && docker build -t dbdelta .
cd ../node_delta && docker build -t nodedelta .
cd ../nginx_delta && docker build -t nginxdelta .

#Inicia os containers
docker container run -d --name dbdelta --network delta dbdelta

sleep 5

docker container run -d -p 8888:8888 --name nodedelta --network delta nodedelta

sleep 5

docker container run -d -p 80:80 --name nginxdelta --network delta nginxdelta