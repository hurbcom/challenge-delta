#!/bin/bash

Principal() {

  echo "Deploy Projeto Delta"

  echo

  echo "1. Deploy utilizando Dockerfile"

  echo "2. Desativar ambiente Dockerfile"

  echo "3. Sair do menu"

  echo

  echo -n "Qual a opção desejada? "

  read opcao

  case $opcao in

    1) Iniciar ;;

    2) Desativar ;;

    3) exit ;;

    *) "Opção desconhecida." ; echo ; Principal ;;

  esac

}

 

Iniciar() {

  clear

echo Verificando se tem docker instalado
  #Instalando Docker
if [[ $(which docker) ]]; then
    echo "Docker Instalado"
    
  else
    echo "Instalando Docker"
    curl -fsSL https://get.docker.com | bash 
fi

echo Verificando se existe rede para comunicação dos containers
#Cria rede para comunicação dos containers
if [[ $(docker network ls | grep delta) ]]; then
    echo "Rede delta já existe"

  else
    echo "Criando rede delta"
    sudo docker network create -d bridge delta
fi

echo Inicinando o build das imagens
#Faz o build das imagens
cd ./db_delta && sudo docker build -t dbdelta .
cd ../node_delta && sudo docker build -t nodedelta .
cd ../nginx_delta && sudo docker build -t nginxdelta .

echo Iniciando os cointainers
#Inicia os containers
sudo docker container run --env-file ../env.list -d --name dbdelta --network delta dbdelta

sleep 5

sudo docker container run --env-file ../env.list -d -p 8888:8888 --name nodedelta --network delta nodedelta

sleep 5

sudo docker container run -d -p 80:80 --name nginxdelta --network delta nginxdelta
    
  
  
  Principal

}

 

Desativar() {


  clear

  #Parando e removendo os containers

  echo Parando os container do projeto Delta

  sudo docker container stop nginxdelta nodedelta dbdelta

  echo Removendo os containers do projeto Delta

  sudo docker container rm nginxdelta nodedelta dbdelta

  #Removendo as imagens

  echo Removendo as imagens do projeto Delta

  sudo docker image rm nginxdelta nodedelta dbdelta
  
  Principal

}

Principal
