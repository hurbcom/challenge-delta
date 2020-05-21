#!/bin/bash

Principal() {

  echo "Start Cluster Minikube - Projeto Delta"

  echo

  echo "1. Iniciar o cluster projeto delta"

  echo "2. Desativar o cluster projeto delta"

  echo "3. Verificar URL do cluster"

  echo "4. Sair do menu"

  echo

  echo -n "Qual a opção desejada? "

  read opcao

  case $opcao in

    1) Iniciar ;;

    2) Desativar ;;

    3) Listaurl ;;

    4) exit ;;

    *) "Opção desconhecida." ; echo ; Principal ;;

  esac

}

 

Iniciar() {

  clear

  echo Realizando Deploy
  
  echo -n "$(minikube ip) k8sdelta" >> /etc/hosts
  kubectl create namespace delta
  kubectl apply -f secrets.yaml --namespace=delta
  kubectl apply -f dbdelta.yaml --namespace=delta
  sleep 10
  kubectl apply -f nodedelta.yaml --namespace=delta
  kubectl apply -f nginx-ingress.yaml --namespace=delta
    
  
  
  Principal

}

 

Desativar() {


  clear

  echo Desativando o cluster delta

  kubectl delete ns delta
  
  Principal

}

Listaurl() {

  clear

  echo ---------

  echo http://k8sdelta/packages
  echo http://"$(minikube ip)"/packages

  echo ---------

    
  Principal

}

Principal
