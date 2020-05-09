#!/bin/bash -e

function cleanup {
    minikube delete
}
trap cleanup INT QUIT TERM ERR

minikube start --driver=docker --addons=ingress

eval $(minikube docker-env)

docker build -t delta-node:latest node/
docker build -t delta-database:latest database/

eval $(minikube docker-env -u)

kubectl apply -f minikube/delta-node.yaml

kubectl apply -f minikube/delta-database.yaml

kubectl apply -f minikube/delta-ingress.yaml

