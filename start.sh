#! /bin/bash

set +xe

db_pass()
{
	read -p  "Digite sua senha para o banco de dados: " dbpass # le string para ser usada como senha do banco de dados 

}

db_pass

start_cluster() # inicia o deploy do minikube para ser usado pelo cluster
{
	echo "Esse script inicia o minikube automaticamente se existir algum processo do minikube ja existente por favor interrompa o processo"
	sleep 3
	minikube start
	minikube ingress enable
	minikube status
	minikube ip
	kubectl create secret generic secret-mysql --from-literal=password=$dbpass --from-literal=username=root # gera senha e usuario do banco com base na entrada de string solicitada pelo script
	kubectl config use-context minikube # associa o kubectl ao contexto do minikube
}

start_cluster

manifest() # faz o deploy de fato dos manifests do cluster
{
 	for i in $(ls ./source/**/*.yml); do
	 	kubectl apply -f $i
 	done
}

manifest


exit 0
