# <img src="https://avatars1.githubusercontent.com/u/7063040?v=4&s=200.jpg" alt="HU" width="24" /> Desafio Delta - João Ferreira

O projeto consiste em uma API implementada com Node.js​ + MySQL​ para criação e consulta de pacotes.
Você deve:

## Diagrama da infraestrutura do projeto

<img src="./docs/diagram.png">

## Requisitos

- Git
- Docker Engine
- Docker Compose
- Kubernetes (ex. minikube)

## Modo de execução local (Compose)

```
  # Clone o repositório

  $ git clone https://github.com/ojaoferreira/challenge-delta.git

  # Acesse o diretório do projeto

  $ cd ./challenge-delta/

  # Contrua as imagens

  $ docker-compose build

  # Execute o compose (O parametro -d faz a aplicação executar em backgroud)

  $ docker-compose up -d
```

## Modo de execução kubernetes (kubectl)

```
  # Clone o repositório

  $ git clone https://github.com/ojaoferreira/challenge-delta.git

  # Acesse o diretório do projeto

  $ cd ./challenge-delta/

  # Crie os recursos Kubernetes

  $ kubectl apply -f .k8s/

  # Acesse aplicação pelo serviço NodePort

  $ minikube service challenge-delta-proxy -n challenge-delta
```

## Documentação da API

- Cria um pacote
<img src="./docs/request-post.png">

- Lista os pacotes cadastrados
<img src="./docs/request-get.png" width="300">

- Deleta um pacote pelo ID do pacote
<img src="./docs/request-delete.png" width="300">