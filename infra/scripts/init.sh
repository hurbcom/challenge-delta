#!/bin/bash
set -e
source ./toolsInstaller.sh
source ./deploys.sh
source ./builds.sh

function verifyMinikube {
    minikube start --driver=docker
    if [ $? -eq 0 ]; then
        echo "Minikube already installed"
    else
        installMinikube || exit 0
    fi
}

function verifyDocker {
    docker --version 1> /dev/null
    if [ $? -eq 0 ]; then
        echo "Docker already installed"
    else
        installDocker || exit 0
    fi
}

function enableDockerWithoutSudo {
    MY_GROUP=`id -g -n $USER`
    sudo chown ${USER}:${MY_GROUP} /var/run/docker.sock 1> /dev/null
}

function deleteAll {
    deleteNginx || true
    deleteApp || true
    deleteMysql || true
    minikube stop || true
}

function deployAll {
    echo "==================== Deploying MySQL... ===================="
    createMysql

    echo "==================== Deploying app... ===================="
    createApp

    echo "==================== Creating Nginx... ===================="
    createNginx
}

function portForwardApp {
    APP_URL=`minikube service list | grep service-nginx | awk '{ print $8 }'`

    echo "==================== APP ONLINE ===================="
    echo "== Node URL: ${APP_URL}"
    echo "== Port forward: service-nginx:80 to localhost:${1:-'80'} in 5 seconds"
    echo "== Wait..."
    echo "===================================================="
    sleep 5
    sudo kubectl port-forward service/service-nginx ${1:-"80"}:80
}

function main {
    echo "==================== Verify Docker... ===================="
    verifyDocker
    enableDockerWithoutSudo # COMMENT IF YOUR USER IS ROOT

    echo "==================== Verify Minikube... ===================="
    verifyMinikube

    echo "==================== Building app... ===================="
    buildApp

    deployAll

    portForwardApp
}

deleteAll
# main