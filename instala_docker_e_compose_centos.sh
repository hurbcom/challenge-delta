#!/bin/bash

function instala_docker(){
	sudo yum install -y yum-utils
	sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
	sudo yum install --nobest -y docker-ce docker-ce-cli containerd.io
	sudo systemctl start docker
}

function verifica_docker(){
	if [ `docker > /dev/null 2>&1; echo $?` -eq 0 ]
	then
		echo "Docker instalado"
	else
		instala_docker
	fi
}

function instala_compose(){
	sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
}

function verifica_compose(){
        if [ `docker-compose --version > /dev/null 2>&1; echo $?` -eq 0 ]
        then
                echo "Docker-compose instalado"
                exit 0
        else
                instala_compose
        fi
}


verifica_docker
verifica_compose
