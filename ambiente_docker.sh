#!/bin/bash

function verifica_docker(){
	if [ `docker > /dev/null 2>&1; echo $?` -eq 0 ]
	then
		echo "Docker encontrado..."
	else
		echo "Executável não encontrado, use o script instala_docker_e_compose_centos.sh"
		exit 1
	fi
}

case $1 in
	"start" )
		verifica_docker
		echo "Iniciando os containers..."
		echo ""
		docker network create db_node_network
		docker build -t mysql_image -f db/Dockerfile .
		docker run -d --name mysql-server --network db_node_network mysql_image
		docker build -t nodejs_image -f nodejs/Dockerfile .
		docker run -d --name nodejs-server --network db_node_network nodejs_image
		docker network create node_proxy_network
		docker network connect node_proxy_network nodejs-server
		docker build -t nginx_image -f nginx/Dockerfile .
		docker run -d --name nginx-server -p 80:80 --network node_proxy_network nginx_image
		echo ""
		echo "#####################################################################################################"
                echo "A aplicação pode ser acessada pelo endereço http://localhost(local) ou http://seu_ip(local e externo)"
		echo "#####################################################################################################"
		;;
	"stop")
		verifica_docker
		echo "Parando os containers..."
		echo ""
		docker stop mysql-server nodejs-server nginx-server
		docker container rm mysql-server nginx-server nodejs-server
		docker network rm db_node_network node_proxy_network
		docker rmi mysql:5.7 mysql_image:latest node nodejs_image:latest nginx nginx_image:latest 
	;;
	*)
		echo "Informe um parâmetro(start ou stop)!"
	;;
esac
