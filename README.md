# <img src="https://avatars1.githubusercontent.com/u/7063040?v=4&s=200.jpg" alt="HU" width="24" /> Desafio Delta

Serão basicamente 2 partes que vamos focar nesse teste:

- Sua habilidade de desenvolvimento.
- Sua habilidade de colocar o código para rodar usando específicas tecnologias.

Alguns passos terão requerimentos vagos ou erros. Não há resposta certa ou errada, queremos avaliar sua postura diante do desafio assim o modo como você o desenvolverá.

#
# Parte 1 - Desenvolvimento

## Pre-requisitos
* Git
* Conta no Github
#
### Como fazer

O projeto deve usar controle de versão no git e armazenado/subido para o Github em um repositório privado na sua conta.

Quando terminar o desafio, convide o usuário `automator-hurb` para colaborador do seu repositório do desafio para que possamos fazer a avaliação.
#
## A tarefa

Usando Go, Python3 ou NodeJS, sua tarefa, será implementar um API REST que faça CRUD em produtos armazenados em um banco de dados MySQL 5.7.

A API terá que fazer a validação dos dados de entrada. Exemplo: SKU é único em POST e PUT.
#
## Requisitos
- Kubernetes deployment manifests para rodar, balancear, limitar requests e escalar utilizando HPA no Minikube v13.0

- Script para popular o banco de dados com dummy data.

- Testes unitários

## Bibliotecas de terceiros
Você poderá usar bibliotecas de terceiros, como por exemplo o driver para falar com o banco de dados, mas encorajamos que use o menor número de bibliotecas possíveis.

# API de Produtos
Response codes
- 200 OK
- 201 Created
- 400 Bad Request
- 404 Not Found
- 500 Internal Server Error

---
Todas as respostas de erro (400, 404, 500) devem retornar um objeto único com uma única chave chamada "errorText" e o valor (string) descrevendo o erro.

Exemplo:

```
{
 "errorText": "The error message"
}
```
## Definição do "produto"
```
{
    "productId"​: ​<int>​, ​(readonly, unique)
    "title"​: ​<string>​, ​(required for POST)
​    "sku"​: ​<string>​, ​(required for POST, unique)
    "barcodes"​: ​[<string>]​, (unique)
    "description"​: <string|null>​, (default null)
    "attributes"​: ​[<attribute>]​, ​
    "price"​: ​<money>​, ​(default "0.00")
    "created"​: <timestamp>​, (readonly)
    "lastUpdated": <timestamp|null>​ (readonly)
}
```


## Endpoints
```GET /api/products```

**Parametros de query**

Todos os parametros são opcionais



| Parâmetro | Descrição | Tipo | Default |
|---|---|---|---|
| start | Inicio do index | int | 0 |
| num | Numero de indexes retornados | int | 10 |
| sku | Filtrar por sku | string | --- |
| barcode | Filtrar por barcode | string |  |
| fields | Campos do produto que serão retornados da resposta | string, separado por vírgulas | --- |

- Exemplo da URL
```
http://127.0.0.1:8080/api/products?start=40&num=2&fields=productId,title
```

- Retorno sucesso
```
{
"totalCount"​: <int>​,
"items"​: [​<product>​]
}
```
- Exemplo de retorno
```
{
​"totalCount"​: 126​,
"items"​: [
{
    "productId"​: 45​,
​    "title": "Awesome socks"
    },
    {
    "productId"​: 46​,
    "title"​: "Batman socks"
        }
    ]
}
```
---

## GET
```
GET /api/products/{productId}
```

**Parametros de query**

Todos os parametros são opcionais



| Parâmetro | Descrição | Tipo | Default |
|---|---|---|---|
| fields | Campos do produto que serão retornados da resposta | string, separado por vírgulas | --- |

Exemplo Retorno sucesso
```
{
"productId"​: 45​,
"title"​: "Awesome socks"​,
​"sku"​: "SCK-4511"​,
​"barcodes"​: [​"7410852096307"​],
"description"​: null​,
"attributes"​: [
    {
​       "name"​: "color"​,
​       "value"​: "Red"
    },
    {
        "name"​: "size"​,​
        "value"​: "39-41"
    },
],
"price"​: "89.00",
"created"​: 1554472112​,
​"lastUpdated"​: null
}
```


Retorno erro
```
{
"errorText"​: "Can’t find product (<productId>)"
}
```
---
## POST

```
POST​ /api/products
```

Para POST, um subset de produto é permitido, porém todos os campos requeridos para criação devem estar presentes.

**Body** content
```
{
​"title": "Awesome socks"​,
"sku"​: "SCK-4511"​,
"barcodes"​: [​"7410852096307"​],
​"description"​: null​,
​"attributes"​: [
        {
​
            "name"​: "color"​,
            "value"​: "Red"​,
        },
        {
​            "name": "size"​,
            "value"​: "39-41"​,
        },
    ],
    ​"price"​: "89.00"​,
}
```
* Resposta sucesso (int)
```
45
```
* Resposta erro
```
{
​"errorText"​: "SKU 'SCK-4511' already exists"
}
```
---
## PUT

```
PUT​ /api/products/{productId}
```

Novamente, um subset de produto é permitido.

Retorno sucesso (bool)
```
true
```

Retorno erro
```
{
 "errorText": "​ Invalid sku, can not be null"
}
```
---
## DELETE
```
DELETE​ /api/products/{productId}
```

Retorno sucesso (bool)
```
true
```
Retorno erro
```
{
​"errorText"​: "Product with productId (<productId>) does not exist"
}
```

# Definições

## Tipos API

Atributos
```
{
    "name"​: ​<string>​, ​(required)​
    "value"​: ​<string>​ ​(required)
}
```

## Mysql schema
```
CREATE​ SCHEMA ​IF​ ​NOT​ ​EXISTS​ ​`hurb_test_assignment`
DEFAULT ​CHARACTER​ SET​ utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE​ ​TABLE​ ​IF​ ​NOT​ ​EXISTS​ ​`hurb_test_assignment`​.`product`​ (
`product_id`​ INT​ UNSIGNED ​NOT​ NULL​ AUTO_INCREMENT,
`title`​ VARCHAR​(32​) NOT​ NULL​,
`sku`​ VARCHAR​(32​) NOT​ NULL​,
`description`​ VARCHAR(1024​) NULL​,
`price`​ DECIMAL​(12​,2)NOT​ NULL​ DEFAULT ​0.00,
`created`​ DATETIME​ NOT​ NULL​,
`last_updated`​ DATETIME​ NULL,
PRIMARY​ KEY​ (​`product_id`​),
UNIQUE INDEX (​`sku`​ ASC​),
INDEX (​
`created`​
),
INDEX (​`last_updated`​)
);

CREATE​ ​TABLE​ ​IF​ ​NOT​ ​EXISTS​ ​`hurb_test_assignment`​.`product_barcode`​ (
`product_id`​ INT​ UNSIGNED ​NOT​ NULL​,
`barcode`​ VARCHAR(32​) NOT​ NULL​,
PRIMARY​ KEY​ (​`product_id`​, `barcode`​),
UNIQUE INDEX (​`barcode`​)
);

CREATE​ ​TABLE​ ​IF​ ​NOT​ ​EXISTS​ ​`hurb_test_assignment`​.`product_attribute`​ (
`product_id`​ INT​ UNSIGNED ​NOT​ NULL​,
`name`​ VARCHAR​(16​) NOT​ NULL​,
`value`​ VARCHAR​(32​) NOT​ NULL​,
PRIMARY​ KEY​ (​`product_id`​, `name`​)
);
```

#
# Parte 2 - Entrega da aplicação

- Sua aplicação deve rodar no Minikube v13.0 + kubectl
- Você deve escrever os manifestos do Kubernetes para criar o *Ingresso* para expor sua app, 1 container para rodar sua aplicação e 1 container para rodar o Banco de dados. Você deve utilizar Serviços e deployments do K8s assim como HPA setando limites de requests e uso de recursos do sistema. Os números desses limites devem ser baixos o suficiente para ser possivel ver o HPA entrar em ação a partir de requisições da máquina local.

* Todos os logs devem ser visiveis a partir do `kubectl logs -f <pod>`

* A segurança do cluster será levada em consideração.

* O projeto deve rodar utilizando apenas 1 comando (assumindo que a pessoa já tenha o minikube instalado e rodando).

## Critério de avaliação

-   **Organização do código**: Separação de módulos - código app e infra.
-   **Clareza**: O README explica de forma resumida qual é o problema e como pode rodar a aplicação?
-   **Assertividade**: A aplicação está fazendo o que é esperado? Se tem algo faltando, o README explica o porquê?
-   **Legibilidade do código** (incluindo comentários)
-   **Segurança**: Existe alguma vulnerabilidade clara que não tenha sido endereçada?
-   **Cobertura de testes** Teste unitários
-   **Histórico de commits** (estrutura e qualidade, titulos e descrição)
-   **Escolhas técnicas**: A escolha das bibliotecas, arquitetura, etc, é a melhor escolha para a aplicação?
-   **Comunicação**: Se você não conseguiu completar todo o teste, o README contém o que ficou faltando?

## Dúvidas

Quaisquer dúvidas que você venha a ter, consulte as [_issues_](https://github.com/HurbCom/challenge-delta/issues) para ver se alguém já não a fez e caso você não ache sua resposta, abra você mesmo uma nova issue!

Boa sorte e boa viagem! ;)

<p align="center">
  <img src="ca.jpg" alt="Challange accepted" />
</p>
