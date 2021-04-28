# <img src="https://avatars1.githubusercontent.com/u/7063040?v=4&s=200.jpg" alt="HU" width="24" /> Desafio Delta
<<<<<<< HEAD
Autor: Luiz Carlos Martins

## 1. Tecnologias utilizadas
- A aplicação (API) foi feita em JavaScript, utilizando o Node.js como runtime. As bibliotecas utilizadas foram: o express, para acelerar a criação do server e todo o seu roteamento; o mysql2, que é bastante parecido com a biblioteca mysql, porém aceita código assíncrono; e o dotenv, para carregar dados mais "sensíveis" que deveriam chegar como variáveis de ambiente.
- A infraestrutura foi feita utilizando o minikube, que nada mais é do que um kubernetes local para testes. Essa infra local é subida através de arquivos shell script. Esses scripts fazem todo o trabalho de verificar se as ferramentas necessárias (Docker e Minikube) estão prontas para serem utilizadas, build e push da imagem, carregamento dos yamls para os recursos K8S necessários e deploy.

## 2. Estrutura
A app e a infra estão separadas, respectivamente, nas duas pastas a partir da raiz: application e infra.
### 2.1 App
Entrando na pasta da aplicação, veremos todo o código desenvolvido para a API. Dentro desta pasta há o arquivo **dev.env** com as informações padrões para o ambiente local (o que não deve ser feito, mas está no repositório para acelerar o processo de deploy local). Temos também o **package.json** com as informações básicas do projeto e o **index.js** que é o entrypoint da aplicação.  
Além desses arquivos temos duas pastas: a pasta **config** possui dois arquivos utilizados pelo entrypoint. Um arquivo faz a configuração do server setando middlewares e carregando o roteamento, enquanto o outro arquivo faz a criação da conexão do banco de dados. A outra pasta, **app** possui 3 subdivisões: 
- uma para o roteamento, pasta **route**, com um arquivo fazendo as rotas;
- uma para a lógica de negócio, pasta **controller**, que é o meio de campo entre o trabalho com o banco de dados e a exibição desses dados em tela;
- e outra para a manipulação de dados no banco, pasta **model**, que faz todo o trabalho de leitura e escrita junto ao banco.
### 2.2 Infra
A pasta de infra é dividida em 3 partes:
- **docker** - Contém um Dockerfile utilizado para buildar a aplição, além de um exemplo de arquivo de autenticação do docker (Arquivo que fica localizado em ~/.docker/.dockerconfig.json após um login com sucesso). Ambos os arquivos serão utilizados na hora de subir a infra.
- **k8s** - Contém todos os templates necessários para subir os recursos que serão precisos para o desafio.
- **scripts** - Contém os shell scripts utilizados para subir a infraestrutura e deploy do desafio.
### 2.3 Recursos e informações
GitFlow:
- Foram utilizadas duas branchs como as principais: master e develop. Todas as necessidades para a app foram feitas criando uma branch feature/* a partir da develop, então depois de pronto foi feito uma PR da feature para a develop (fazendo com que ela esteja atualizada com as novas features). Após testado e funcionando é feita a PR de develop para master.
#
Resumo do Flow das requisições:  
- Basicamente A requisição do usuário bate em um nginx que está configurado como LoadBalancer. Então o nginx faz o proxy reverso para o serviço da aplicação que, por sua vez, se comunica com o banco quando necessário.  
#
MySQL:  
- Porta: 3306
- User: hurb
- Pass: hurbP4SS
- Host: service-mysql
- Recursos: configmap com o mysql-schema padrão; pvc para persistencia de dados; deployment e service.
#
Aplicação:  
- Porta: 3000
- Host: service-nodeapp
- Recursos: deployment, service e HPA.
#
Nginx:  
- Porta: 80
- Tipo: LoadBalancer
- Recursos: configmap com a configuração para o reverse-proxy; deployment e service.


## 3. Iniciando...

### 3.1 Todo o processo:
Primeiramente, caminhe até o diretório dos scripts *infra/scripts*.  
Dê permissão de execução para o arquivo **init.sh** e execute-o. Basta rodar o comando:
```sh
chmod +x init.sh
# OU
sudo chmod +x init.sh

./init.sh
```
O script irá seguir os seguintes passos:
1. Verificar se o docker está instalado utilizando o comando *docker --version* e caso não esteja, o script tentará instalar o docker através dos comandos no script *toolsInstaller.sh*. O script também torna o seu usuário e grupo em owner do .sock do docker (para que possam ser executados comandos sem a utilização do *sudo*)
2. Quase da mesma forma que acima, o script verifica a presença do minikube. A diferença é que o comando é o *minikube start* e caso ocorra tudo bem, é rodado o comando *minikube addons enable metrics-server* para habilitar as métricas de CPU.
3. A aplicação é buildada e então pushada para o docker hub. É nesta etapa que o arquivo de autenticação do docker é necessário. Lembre-se de alterar o arquivo *infra/k8s/app.deployment.sh* com a imagem correta, de acordo com o seu repositório.
4. Inicia o deploy do MySQL, da app + HPA e do Nginx.
* No arquivo **init.sh**. a última linha dentro da função main contém um comando comentado. Este comando faz o port-forwarding do serviço do nginx para a sua porta 80. Descomente-o caso queira testar a app localmente na porta 80.
#
### 3.2 Apenas a aplicação:
Vá até a pasta application e então instale os módulos necessários utilizando o comando:
```sh
npm install
```
Após a instalação das bibliotecas, você pode startar a aplicação em modo dev, onde ela será iniciada pelo nodemon. Sempre que o nodemon identificar alguma mudança no código, ele irá restartar o server.  
Ou você pode startar a app utilizando o modo padrão, que utiliza o node. Seja lá qual for a forma que escolher, o comando a ser executado será um dos dois abaixo:
```sh
npm run dev # MODO DEV
# OU
nom run start # PADRÃO
```

## 4. Pensando em algo grande...
Se esse fosse um projeto para ser executado em larga escala, eu iria pensar em utilizar ferramentas como o terraform, ansible ou jenkins para fazer toda a parte do deploy. Também sugiro que deveriam haver dois repositórios para separar o código de infra e o da aplicação.
A criação das imagens poderiam ser feitas através do próprio github actions, onde setaríamos para que haja um build e um push caso uma das branchs principais (branchs para prod, stg e dev) recebesse um push ou uma PR. Deveria haver também algum tipo de trigger para fazer o redeploy da aplicação com a nova imagem.

## 5. Falhas
Não fiz os Testes Unitários. Não consegui aproveitar tanto o meu tempo quanto imaginei que poderia. Fui focando nas partes que domino mais, pois eu iria perder um bom tempo pesquisando mais sobre testes e também suas boas práticas. Entrego o que consegui finalizar e aguardo ansiosamente pelo feedback.
=======

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
- Kubernetes deployment manifests para rodar, balancear, limitar requests e escalar utilizando HPA no Minikube v1.13.0

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
>>>>>>> 463f3b98e0b63bb0397f20a57656944be9d16a50
