#!/bin/bash

function instala_minikube(){
	sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && sudo chmod +x minikube
	sudo mkdir -p /usr/local/bin/
	sudo install minikube /usr/local/bin/
	minikube start
}

function verifica_minikube(){
	if [ `minikube version > /dev/null 2>&1; echo $?` -eq 0 ]
	then
		echo "Minikube instalado"
	else
		instala_minikube
	fi
}

verifica_minikube
