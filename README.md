# Aplicação CRUD com Node.js + MySQL + Kubernets

## Sobre :star:

Utilizando Node.js foi construido uma API REST simples para realizar o CRUD de produtos armazenados em um banco de dados MySQL.

## Recursos Utilizados :page_facing_up:

* Node.js [v14.15.4-alpine3.12](https://hub.docker.com/_/node)
* MySQL [v5.7.32](https://hub.docker.com/_/mysql)
* Minikube [v1.13.0](https://minikube.sigs.k8s.io/docs/start/)

## Requisitos :mag_right:

* minikube v1.13.0 instalado e em execução.
* metrics-server do minikube habilitado (necessário para o HPA).
```sh
$ minikube addons enable metrics-server
```
* Conhecer o IP externo do NODE, fornecido pelo minikube.
* Software para realizar o CRUD. Por exemplo [Postman](https://www.getpostman.com/)

## Subindo o ambiente :rocket:

1 - Acesse o diretório "k8s", localizado na raiz do repositório;
2 - Primeiro devemos subir o banco de dados, acesse o diretório "database" e execute:
```bash
$ kubectl apply -f .
```
A aplicação testa a conectividade com o banco antes de subir, caso não seja possível a comunicação a aplicação não sobe.

3 - Valide se o pod do banco de dados subiu com sucesso.
```bash
$ kubectl get pods
```
4 - Agora podemos subir nossa aplicação, para isso acesse o diretório "api" e execute:
```bash
$ kubectl apply -f .
```
5 - Valide se o pod da aplicação subiu com sucesso.
```bash
$ kubectl get pods
```
## Executando o CRUD :computer:

Abra o Postman (ou outro recurso) para realizar as ações:

| Método | Verbo HTTP | Endpoint |
|---|---|---|
| Criando um novo Produto | POST | `http://{IP_EXTERNO_NODE}:30001/api/products` |
| Listando todos os Produtos | GET | `http://{IP_EXTERNO_NODE}:30001/api/products` |
| Buscando Produto pelo product_id | GET | `http://{IP_EXTERNO_NODE}:30001/api/products/{id}`|
| Atualizando Produto pelo product_id | PUT | `http://{IP_EXTERNO_NODE}:30001/api/products/{id}`|
| Delanto Produto pelo product_id | DELETE | `http://{IP_EXTERNO_NODE}:30001/api/products/{id}`|

## Executando o teste de Stress :fire:

Acesse o diretório "stress-test", localizado na raiz do repositório;
Altere nas variáveis o IP e porta de acesso a API;
Execute:
```bash
$ ./stress.sh
```
Para visualizar quantas réplicas estão em execução:
```bash
$ kubectl get hpa --watch
```

## Observação e informações relevantes :exclamation:

* O arquivo .env foi comitado propositadamente afim de facilitar a execução do ambiente.
* Cobertura de testes (Teste unitários) não foi aplicado.
* As mensagens de erro e sucesso não foram aplicadas conforme descrito do README do desafio, apesar de existirem poderiam ser mais "amigáveis". 
* O schema foi alterado para ter somente uma tabela.
* Não foi implementado validação das informações de entrada, exceto SKU único.
