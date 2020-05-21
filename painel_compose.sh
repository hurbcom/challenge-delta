#!/bin/bash

Principal() {

  echo "Deploy com Docker Compose Projeto Delta"

  echo

  echo "1. Deploy utilizando Docker Compose"

  echo "2. Desativar ambiente Docker Compose"

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

 #Instalando Docker
 echo Verificando se tem docker instalado
if [[ $(which docker) ]]; then
    echo "Docker Instalado"
    
  else
    echo "Instalando Docker"
    curl -fsSL https://get.docker.com | bash 
fi

#Instalando Composer
echo Verificando se o Dcoker Compose está instalado
if [[ $(which docker-compose) ]]; then
    echo "Compose Instalado"
    
  else
    echo "Instalando Docker Compose"
    sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

#Inicia os containers

echo Iniciando os containers do projeto Delta

sudo docker-compose up -d
  
  Principal

}

 

Desativar() {


  clear

  #Para os containers e remove os serviços

  echo Parando os containers do Projeto Delta
  
  sudo docker-compose down
  
  Principal

}

Principal

