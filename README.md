# challenge-delta

Exemplo de projeto que segue boas práticas de como trabalhar com container e CI utilizando o GitHub Action.

## Requisitos

Vocês precisará das seguintes aplicações para executar o ambiente:

- docker
- docker-compose
- git
- microk8s (desenvolvimento)

```bash
# Se você estiver utilizando o Ubuntu 18.04 ou 20.04,
# execute os comandos abaixo.
sudo apt-get update
sudo apt-get install -y \
	docker-compose docker.io git snapd
sudo snap install microk8s --classic
```

## Como executa a aplicação

Se você deseja apenas testar as aplicações, a maneira mais simples é utilizar o `docker-compose.yml` e baixar as imagens do registry do GitHub:

```bash
# Clone o repositório e entre no diretório
git clone https://github.com/thenets/challenge-delta.git
cd ./challenge-delta/

# Execute o docker-compose
docker-compose up
```

## Como construir e executar localmente (desenvolvimento)

```bash
# Clone o repositório e entre no diretório
git clone https://github.com/thenets/challenge-delta.git
cd ./challenge-delta/

# Construa as imagens
docker-compose build

# Execute o docker-compose
docker-compose up
```
