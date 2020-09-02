#!/bin/bash
echo "Realizando o build das imagens"
#Build db
docker build -t db:latest -f automate/docker/db/Dockerfile .
#Build nodeapp
docker build -t nodeapp:latest -f automate/docker/nodeapp/Dockerfile .
#Build reverse proxy
docker build -t reverseproxy:latest -f automate/docker/reverseproxy/Dockerfile .