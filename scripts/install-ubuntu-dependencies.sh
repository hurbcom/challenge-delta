#!/bin/bash

# Make sure user has privilege
if [ "$(id -un)" != "root" ]; then
	echo "[ERROR] You must be root!"
	echo "        Exiting..."
    exit 1
fi

# Install Docker, docker-compose and Make
sudo apt-get install -y \
	docker-compose docker.io make
