#!/bin/bash

function instala_minikube(){
	sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && sudo chmod +x minikube
	sudo mkdir -p /usr/local/bin/
	sudo install minikube /usr/local/bin/
	minikube start
}

function instala_kubectl(){
	curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
	chmod +x ./kubectl
	sudo mv ./kubectl /usr/local/bin/kubectl
}

function verifica_minikube(){
	if [ `minikube version > /dev/null 2>&1; echo $?` -eq 0 ]
	then
		echo "Minikube instalado"
	else
		instala_minikube
	fi
}

function verifica_kubectl(){
        if [ `kubectl version > /dev/null 2>&1; echo $?` -le 1 ]
        then
                echo "Kubectl instalado"
        else
                instala_kubectl
        fi

}

verifica_minikube
verifica_kubectl
