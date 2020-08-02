#!/bin/bash

# Install Docker, docker-compose and Make
sudo apt-get install -y \
	docker-compose docker.io make

# Install microk8s
sudo snap install microk8s --classic
