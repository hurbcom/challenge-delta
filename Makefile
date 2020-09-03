default: help
.SILENT:

help:
	echo
	
	echo "Challenge-delta"
	
	echo
	
	echo "Please use 'make <parameters>'"
	
	echo
	
	echo "Parameters:"
	
	echo "  packages - Install all packages you need"
	
	echo "  deploy - Start minikube cluster and deploy app"
	
	echo "  destroy - Delete app and minikube cluster"
	
	echo "  list - List all packages"
	
	echo "  create - Create packages. Usage: make create package=<name_of_the_package>"
	
	echo "  delete - Delete packages. Usage: make delete id=<id_of_the_package>"
	
	echo ""

dependencies:
	echo install kubectl
	curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.19.0/bin/linux/amd64/kubectl"
	chmod +x ./kubectl
	sudo mv ./kubectl /usr/local/bin/kubectl
	
	
	echo install minikube
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
	sudo mkdir -p /usr/local/bin/
	sudo install minikube /usr/local/bin/

	echo install docker
	curl -fsSL https://get.docker.com | sudo sh
	sudo usermod -aG docker $$USER
	newgrp docker
	
start:
	echo Start minikube
	minikube start
	minikube addons enable ingress
	
deploy:	
	echo "Build and deploy images"
	echo "Build db"
	docker build -t db:latest -f automate/docker/db/Dockerfile .
	
	echo "Build nodeapp"
	docker build -t nodeapp:latest -f automate/docker/nodeapp/Dockerfile .
	
	echo "Deploy hurb Challenge-delta"
	kubectl create -f automate/k8s/namespace.yml
	kubectl create -f automate/k8s/db.yml
	kubectl create -f automate/k8s/nodeapp.yml
	kubectl create -f automate/k8s/ingress.yml
	sudo -- sh -c "echo -n $(minikube ip) challenge-delta.info >> /etc/hosts"

destroy:
	minikube delete --all --purge

list:
	echo "All packages list bellow"
	curl -sb -H "Content-Type: application/json"  "http://challenge-delta.info/packages"

create:
ifdef package
	curl -X POST \
	-H "Content-Type: text/plain" \
	-d "$(package)" \
	http://challenge-delta.info/packages
else
	echo 'Package is not defined'
	echo 'Usage: make create package=<name_of_the_package>'
endif

delete:
ifdef id
	curl -X DELETE \
	http://challenge-delta.info/packages/$(id)
else
	echo 'Id is not defined'
	echo 'Usage: make delete id=<id_of_package>'
endif