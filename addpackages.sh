#!/bin/bash

Principal() {

  echo "Packages - Projeto Delta"

  echo

  echo "1. Adicionar pacote"

  echo "2. Remover pacote via ID"

  echo "3. Sair do menu"

  echo

  echo -n "Qual a opção desejada? "

  read opcao

  case $opcao in

    1) Adicionar ;;

    2) Deletar ;;

    3) exit ;;

    *) "Opção desconhecida." ; echo ; Principal ;;

  esac

}

 

Adicionar() {

  clear

  echo -n "Qual o nome do pacote? "

  read pack

  curl -X POST 'http://localhost/packages' -H 'Content-Type: text/plain' -d $pack 

  Principal

}

 

Deletar() {

  clear

  echo -n "Qual o ID do pacote deseja deletar? "

  read numid 

  curl -X DELETE http://localhost/packages/$numid

  Principal

}

Principal
