#!/bin/bash

set -e

pushd "$(dirname "$(readlink -f "$0")")"
DOCKERCOMPOSE_PATH="$(which docker-compose &2> /dev/null)"
MINIKUBE_PATH="$(which minikube &2> /dev/null)"
JQ_PATH="$(pwd)/jq"
KUBECTL_PATH="$(which kubectl &2> /dev/null)"

source .env

if [ ! -f "$JQ_PATH" ]; then
    curl -Lo "$JQ_PATH" https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe \
        && chmod +x "$JQ_PATH"
fi


if [ "$DOCKERCOMPOSE_PATH" == "" ]; then
    DOCKERCOMPOSE_PATH="$(pwd)/minikube"
    if [ ! -f "$DOCKERCOMPOSE_PATH" ]; then
        curl -Lo "$DOCKERCOMPOSE_PATH" https://github.com/docker/compose/releases/download/1.26.2/docker-compose-Windows-x86_64.exe \
            && chmod +x "$DOCKERCOMPOSE_PATH"
    fi
fi

if [ "$MINIKUBE_PATH" == "" ]; then
    MINIKUBE_PATH="$(pwd)/minikube"
    if [ ! -f "$MINIKUBE_PATH" ]; then
        curl -Lo "$MINIKUBE_PATH" https://storage.googleapis.com/minikube/releases/latest/minikube-windows-amd64 \
            && chmod +x "$MINIKUBE_PATH"
    fi
fi

if [ "$KUBECTL_PATH" == "" ]; then
    KUBECTL_PATH="$(pwd)/kubectl"
    if [ ! -f "$KUBECTL_PATH" ]; then
        KUBECTL_STABLE=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
        curl -LO "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_STABLE}/bin/windows/amd64/kubectl.exe" \
            && chmod +x "$KUBECTL_PATH"
    fi
fi

MINIKUBE_STATUS="$($MINIKUBE_PATH status minikube -f '{{.Host}}')" || true
if [[ "$MINIKUBE_STATUS" != "Running" ]]; then
    "$MINIKUBE_PATH" start --driver=virtualbox
fi

eval $($MINIKUBE_PATH -p minikube docker-env --shell bash)
MINIKUBE_IP="$($MINIKUBE_PATH ip)"

function _createImages() {
    docker build -f docker/app.dockerfile -t "$APP_IMAGE_NAME" --build-arg IMAGE="$APP_BASE_IMAGE" .
    docker build -f docker/db.dockerfile -t "$DB_IMAGE_NAME" --build-arg IMAGE="$DB_BASE_IMAGE" .
    docker build -f docker/proxy.dockerfile -t "$PROXY_IMAGE_NAME" --build-arg IMAGE="$PROXY_BASE_IMAGE" .
}

function _enableAddonIngress() {
    if [ "$("$MINIKUBE_PATH" addons list -o json | $JQ_PATH  '.ingress | select(.Status == "disabled")')" != "" ]; then
        # Once the ingress is enabled, it is not yet available.
        # This sleep is just to wait for the service to be ready.
        "$MINIKUBE_PATH" addons enable ingress && sleep 10
    fi
}

function _disableAddonIngress() {
    if [ "$("$MINIKUBE_PATH" addons list -o json | $JQ_PATH  '.ingress | select(.Status == "enabled")')" != "" ]; then
        # Once ingress is disabled, port 80 is still in use.
        # This sleep is just to wait for the door to be released.
        "$MINIKUBE_PATH" addons disable ingress && sleep 10
    fi
}

# Functions for interacting with the API
function createPackage(){
    value="$1"
    echo "${value}"
    curl -X POST "http://${MINIKUBE_IP}/packages" -H "Content-type: text/plain" -d "$value"
}

function deletePackage(){
    id=$1
    curl -X DELETE "http://${MINIKUBE_IP}/packages/${id}"
}

function listPackages() {
    curl -X GET "http://${MINIKUBE_IP}/packages" | "$JQ_PATH" .
}

# Functions for docker deployment with docker-compose or Kubernetes with kubectl
function startDockerCompose() {
    _createImages
    _disableAddonIngress
    "$DOCKERCOMPOSE_PATH" -f docker/docker-compose.yaml up
}

function startKube() {
    CONTEXT="minikube"
    NAMESPACE="delta"
    ACTION="apply"

    if [ "$1" != "" ]; then
        ACTION=$1
    fi

    _createImages
    _enableAddonIngress

    "$KUBECTL_PATH" create namespace "$NAMESPACE" --dry-run=client -o yaml | \
        "$KUBECTL_PATH" --context "$CONTEXT" "$ACTION" -f -
    "$KUBECTL_PATH" create secret generic --dry-run=client db-secrets -o yaml --from-env-file=.db.secrets | \
        "$KUBECTL_PATH" --context "$CONTEXT" --namespace "$NAMESPACE" "$ACTION" -f -
    "$KUBECTL_PATH" --context "$CONTEXT" --namespace "$NAMESPACE" "$ACTION" -f k8s/db.yaml
    "$KUBECTL_PATH" --context "$CONTEXT" --namespace "$NAMESPACE" "$ACTION" -f k8s/app.yaml
    "$KUBECTL_PATH" --context "$CONTEXT" --namespace "$NAMESPACE" "$ACTION" -f k8s/ingress.yaml
}

#########################
# The command line help #
#########################
display_help() {
    echo
    echo "Usage: $(basename $0) " >&2
    echo
    echo "  -h --help                 This is help"
    echo "  createPackage  value      Creates a travel package.."
    echo "  deletePackage  id         Initializes the project using the docker-compose."
    echo "  listPackages              Initializes the project using the docker-compose."
    echo "  startDockerCompose        Initializes the project using the docker-compose."
    echo "  startKube  action         Initializes the project using the docker-compose."
    echo "               action: apply, create, delete, describe"
    echo
    exit 1
}

case $1 in
    -h) display_help ;;
    --help) display_help ;;
    "") display_help ;;
    startDockerCompose) runningDockerCompose ;;
    runningKube) runningKube "$2" ;;
    startKube) createPackage "$2" ;;
    deletePackage) deletePackage "$2" ;;
    listPackages) listPackages ;;
esac
