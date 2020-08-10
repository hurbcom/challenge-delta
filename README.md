# <img src="https://avatars1.githubusercontent.com/u/7063040?v=4&s=200.jpg" alt="HU" width="24" /> Desafio Delta

Desafio executado utilizando Docker, Docker Compose e Kubernetes(Minikube):
- Iniciando o ambiente com o Docker:
    -   Execute o comando `git clone https://github.com/fmottamendes/challenge-delta` para clonar o repositório.
    -   Execute o comando `cd challenge-delta; bash instala_docker_e_compose_centos.sh` para instalar o pacote docker e docker-compose(CentOS 8)
    -   Execute o comando `bash ambiente_docker.sh start`, para iniciar os containers.

<p align="center">
  <img src="img/docker.png" alt="Ambiente Docker" />
</p>
    
- Iniciando o ambiente com o Docker Compose:
    -   Execute o comando `git clone https://github.com/fmottamendes/challenge-delta` para clonar o repositório.
    -   Execute o comando `bash instala_docker_e_compose_centos.sh` para instalar o pacote docker e docker-compose(CentOS 8)
    -   Execute o comando `docker-compose up -d`, para iniciar os containers

<p align="center">
  <img src="img/compose.png" alt="Ambiente Docker Compose" />
</p>

- Iniciando o ambiente com o Kubernetes(Minikube):
    -   Execute o comando `git clone https://github.com/fmottamendes/challenge-delta` para clonar o repositório.
    -   Execute o comando `cd challenge-delta;bash instala_minikube.sh` para instalar o Kubectl e Minikube(Requer Hypervisor, Virtualbox ou KVM)
    -   Execute o comando `bash ambiente_minikube.sh`, para iniciar os deploys, service e ingress no Kubernetes

<p align="center">
  <img src="img/kubernetes.png" alt="Ambiente Minikube" />
</p>

<p align="center">
  <img src="ca.jpg" alt="Challange accepted" />
</p>
