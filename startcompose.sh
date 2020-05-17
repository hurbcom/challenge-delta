#!/bin/bash

#Instalando Docker
if [[ $(which docker-composer) ]]; then
    echo "Compose Instalado"
    
  else
    echo "Instalando Docker Compose"
    sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

#Inicia os containers

sudo docker-compose up -d