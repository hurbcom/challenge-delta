#!/bin/bash
source ./toolsInstaller.sh

function verifyMinikube {
    minikube start --driver=docker 1> /dev/null
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

function main {
    echo "Docker..."
    verifyDocker
    echo "Minikube..."
    verifyMinikube
}

main