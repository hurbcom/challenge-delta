#!/bin/bash

Principal() {

  echo "Packages - Projeto Delta"

  echo

  echo "1. Adicionar pacote"

  echo "2. Remover pacote via ID"

  echo "3. Listar os pacotes"

  echo "4. Sair do menu"

  echo

  echo -n "Qual a opção desejada? "

  read opcao

  case $opcao in

    1) Adicionar ;;

    2) Deletar ;;

    3) Listar ;;

    4) exit ;;

    *) "Opção desconhecida." ; echo ; Principal ;;

  esac

}

 

Adicionar() {

  clear

  echo -n "Qual o nome do pacote? "

  read pack


   
  curl -X POST http://k8sdelta/packages -H 'Content-Type: text/plain' -d $pack 
  
  Principal

}

 

Deletar() {

  clear

  echo -n "Qual o ID do pacote deseja deletar? "

  read numid 

  curl -X DELETE http://k8sdelta/packages/$numid

  Principal

}

Listar() {

  clear

  curl -X GET http://k8sdelta/packages | json_pp

    
  Principal

}

Principal
