
# Prooduct API
API Para realizar o CRUD em uma base Mysql, realizando consultas de acordo com rota de API especificadas.

## Rotas
|Rotas|Método|
|-----|------|
|/api/products|`GET`|
|/api/products|`POST`|
|/api/products/{productId}|`GET`|
|/api/products/{productId}|`PUT`|
|/api/products/{productId}|`DELETE`|

## Caso de uso
- Para realizar o deploy da aplicação basta executar o comando
```bash
   ./build.sh deploy
```

- Para popular a database, basta executar o comando
```bash
   ./build.sh populate
```

- Para deletar o ambiente basta executar o comando

- Para realizar o deploy da aplicação basta executar o comando
```bash
   ./build.sh destroy
```
## Recursos Criados
 - Deployment banco de dados MySQL 5.7
 - Deployment rest-api

## Notes
Não conseguir desenvover a API, pois ainda não tenho skill de desenvolvimento, sou um profissional de infraestrutura e cloud, com o pouco conehcimento que tenho de python, tentei desenvolver usando essa linguagem, mas nao obtive sucesso.