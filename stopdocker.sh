#!/bin/bash

#Parando e removendo os containers

echo Parando os container do projeto Delta

docker container stop nginxdelta nodedelta dbdelta

echo Removendo os containers do projeto Delta

docker container rm nginxdelta nodedelta dbdelta

#Removendo as imagens

echo Removendo as imagens do projeto Delta

docker image rm nginxdelta nodedelta dbdelta