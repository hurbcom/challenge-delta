# <img src="https://avatars1.githubusercontent.com/u/7063040?v=4&s=200.jpg" alt="HU" width="24" /> Desafio Delta

## Introdução

O código foi feito para o desafio Delta da Hurb, onde era necessário criar a estrutura para uma API implementada em Node.js + MySQL para criar e consultar pacotes. Toda a estrutura está contaneirizada usando docker e automatizada usando shell scripts, docker compose e um Makefile.

## Pré-requisitos

É necessário ter instalado docker e docker-compose na máquina.

## Estrutura do projeto

```
.
├── Makefile
├── README.md
├── ca.jpg
├── db
│   ├── Dockerfile
│   └── scripts
│       └── database_schema.sql
├── diagram.pdf
├── docker-compose.yml
├── nginx
│   ├── Dockerfile
│   ├── conf
│   │   └── delta.conf
│   └── html
│       ├── 404.html
│       └── 50x.html
├── node
│   ├── Dockerfile
│   └── app
│       ├── node_modules
│       ├── package.json
│       └── server.js
├── pull-request.txt
└── test.sh
```

## Como usar

Toda a automação foi criada e pode ser utilizada através de um Makefile. 

Todos os comandos podem ser usados da seguinte maneira:

>> _make_ **target**

## Comandos comuns

### Setup de toda a aplicação e estrutura

>> make run

### Criando pacotes

>> make create package=(nome_do_pacote)

### Visualizando pacotes no banco

>> make packages

### Deletando pacotes

>> make delete id=(id_do_pacote)

### Testando a aplicação e estrutura

>> make test

### Visualizando todos os logs

>> make logs

### Derrubando toda a aplicação

>> make down

### Buscando ajuda

>> make help
