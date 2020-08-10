#!/bin/bash

function inicia_kubernetes(){
	kubectl apply -f k8s/deployment.yml
	kubectl apply -f k8s/service.yml
	kubectl apply -f k8s/ingress.yml
	ip=`minikube ip`
	echo ""
	echo "######################################################################################"
	echo "Adicione a entrada abaixo no arquivo /etc/hosts da máquina que irá acessar a aplicação"
	echo "$ip	desafio-hurb"
	echo "Acesse no navegador o endereço http://desafio-hurb"
	echo "######################################################################################"
}

function verifica_minikube(){
	if [ `minikube version > /dev/null 2>&1; echo $?` -eq 0 ]
	then
		inicia_kubernetes
	else
		echo "Minikube não instalado, use o script instala_minikube.sh para instalar"
	fi
}

verifica_minikube
