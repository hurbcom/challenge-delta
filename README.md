# <img src="https://avatars1.githubusercontent.com/u/7063040?v=4&s=200.jpg" alt="HU" width="24" /> Desafio Delta
## Descrição
Para resolver o desafio foram feitas duas soluções:

-   Utilizando **docker** e **docker-compose**
-	Utilizando **minikube** e **kubectl**


## Docker e Docker-compose

-   Pré-requisitos:
	- [docker](https://docs.docker.com/get-docker/)
    - [docker-compose](https://docs.docker.com/compose/install/) 
-   Utilização:
	- ```docker-compose up -d ```
	- **Ver pacotes** ```curl localhost/packages``` 
	- **Criar pacotes** ```curl -X POST localhost/packages -d teste```
	- **Deletar pacotes** ```curl -X DELETE localhost/packages/$(id)```
## Minikube e kubectl
-   Pré-requisitos:
	- [docker](https://docs.docker.com/get-docker/)
    - [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
	- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
-   Utilização:
	- Foi feito um script de automação da stack do minikube:
		- Para sua utilização é necessário que o script nao seja executado como root e que o usuario tenha permissoes para rodar o comando docker
		- Caso queira adicionar seu usuário no grupo docker: ```sudo usermod -aG docker $USER``` após rodar o comando lembrar de fazer log in e log out
		- ``` ./minikube/start-minikube.sh ```
		- Como foi utilizado o ingress é necessário adicionar um dns local em /etc/hosts
			- adicionar usando o comando como root ``` echo -n "$(minikube ip) minikube-dns" >> /etc/hosts```
		- **Ver pacotes** ```curl minikube-dns/packages``` 
		- **Criar pacotes** ```curl -X POST minikube-dns/packages -d teste```
		- **Deletar pacotes** ```curl -X DELETE minikube-dns/packages/$(id)```