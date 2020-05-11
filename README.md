# <img src="https://avatars1.githubusercontent.com/u/7063040?v=4&s=200.jpg" alt="HU" width="24" /> Desafio Delta
## Descrição
Para resolver o desafio foram feitas duas solucoes:

-   Utilizando **docker** e **docker-compose**
-	Utilizando **minikube** e **kubectl**


## Docker e Docker-compose

-   Pre-requisitos:
	- [docker](https://docs.docker.com/get-docker/)
    - [docker-compose](https://docs.docker.com/compose/install/) 
-   Utilizacao:
	- ```docker-compose up -d ```
	- **Ver pacotes** ```curl localhost/packages``` 
	- **Criar pacotes** ```curl -X POST localhost/packages -d teste```
	- **Deletar pacotes** ```curl -X DELETE localhost/packages/$(id)```
## Minikube e kubectl
-   Pre-requisitos:
	- [docker](https://docs.docker.com/get-docker/)
    - [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
	- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
-   Utilizacao
	- Foi feito um script de automacao da stack do minikube:
		- Para sua utilizacao e necessario que o script nao seja executado como root e que o usuario tenha permissoes para rodar o comando docker
		- Caso queira adicionar seu usuario no grupo docker ```sudo usermod -aG docker $USER``` e fazer log out
		- ``` ./minikube/start-minikube.sh ```
		- Como foi utilizado o ingress e necessario o uso de um dns local em /etc/hosts
			- adicionar usando o comando como root ``` echo -n "$(minikube ip) minikube-dns" >> /etc/hosts```
		- **Ver pacotes** ```curl minikube-dns/packages``` 
		- **Criar pacotes** ```curl -X POST minikube-dns/packages -d teste```
		- **Deletar pacotes** ```curl -X DELETE minikube-dns/packages/$(id)```