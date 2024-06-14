# <img src="https://avatars1.githubusercontent.com/u/7063040?v=4&s=200.jpg" alt="HU" width="24" /> Desafio Delta

[[English](README.md) | [Portuguese](README.pt.md)]

Serão basicamente 2 partes que vamos focar nesse teste:

-   Sua habilidade de colocar o código para rodar usando tecnologias e ferramentas específicas.
-   Seu conhecimento de boas práticas nessas mesmas tecnologias.

Alguns passos terão requerimentos vagos ou erros. Não há resposta certa ou errada, queremos avaliar sua postura diante do desafio assim o modo como você o desenvolverá.

#

# Parte 1 - Desenvolvimento

## Pre-requisitos

-   Git
-   Conta no Github

#

### Como fazer

O projeto deve usar controle de versão no git e armazenado/subido para o Github em um repositório privado na sua conta.

Quando terminar o desafio, convide o usuário `automator-hurb` para colaborador do seu repositório do desafio para que possamos fazer a avaliação.

#

## A tarefa

Implementar a infraestrutura da aplicação que se encontra no diretório `app`.


#

## Requisitos

-    Kubernetes(Minikube v1.32.0)
-    Docker
-    Redis
-    Banco de dados MySQL
-    Aplicação 100% funcional



# Aplicação

A aplicação é composta por dois componentes principais: o frontend e o backend.

## Frontend

O frontend foi desenvolvido utilizando JavaScript e o framework Express, rodando na versão 1.22 do Node.js. A principal responsabilidade do frontend é fazer requisições à API do backend e apresentar os respectivos status.

Quando a API está funcionando corretamente, a mensagem "Up and Running!" é exibida no frontend, juntamente com algumas informações adicionais, como a data atual e o ID da requisição gerado pelo backend.

Se houver algum problema com a API, um erro HTTP 500 é retornado e o detalhe do erro é exibido na tela.

## Backend

O backend foi desenvolvido utilizando a linguagem Go na versão 1.20. Ele é responsável por processar as requisições do frontend que chegam através do endpoint `/api/status`.

Se tudo estiver funcionando corretamente, o backend retorna um status HTTP 200, juntamente com a data atual e o ID da requisição. Se houver algum problema com as dependências da aplicação, como o banco de dados ou o cache não estarem corretamente configurados, o backend retorna um status HTTP 500, com a mensagem do erro.

## Dependências

A aplicação tem como dependências o MySQL e o Redis.



# Parte 2 - Entrega da aplicação

-   Sua aplicação deve rodar no Minikube v1.32.0 + kubectl
-   Você deve escrever os manifestos do Kubernetes para criar o _Ingress_ para expor sua app, 2 containers para rodar sua aplicação, 1 container para rodar o Banco de dados e 1 container para o Redis. Você deve utilizar Serviços e deployments do K8s assim como HPA setando limites de requests e uso de recursos do sistema. 

-   Você deve entregar um desenho com a arquitetura da aplicação.

-   A segurança do cluster e dos contêineres será levada em consideração.

-   O projeto deve rodar utilizando apenas 1 comando (assumindo que a pessoa já tenha o minikube instalado e rodando).

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

