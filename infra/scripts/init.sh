#!/bin/bash
source ./toolsInstaller.sh

function verifyMinikube {
    kubectl --version
    if [ $? eq 0 ]; then
        installMinikube || exit 0
    fi
}

function verifyDocker {
    docker --version
    if [ $? eq 0 ]; then
        installDocker || exit 0
    fi
}

function main {
    verifyDocker
    verifyMinikube
}

main