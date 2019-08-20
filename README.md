# <img src="https://avatars1.githubusercontent.com/u/7063040?v=4&s=200.jpg" alt="HU" width="24" /> Desafio Delta

Construa uma rotina de _deploy_ de 5 nós de um cluster **elasticsearch** (replicável e testável) pronto para ser usado em produção. Você pode usar o que for necessário para isso, como um supervisor, por exemplo.

Use qualquer ferramenta que você prefira para fazer esse desafio, preferencialmente Docker ou uma combinação de Chef com AWS (ou Google Cloud).

## Requisitos

-   Forkar esse desafio e criar o seu projeto (ou workspace) usando a sua versão desse repositório, tão logo acabe o desafio, submeta um _pull request_.
    -   Caso você tenha algum motivo para não submeter um _pull request_, crie um repositório privado no Github e adicione como colaborador o usuário `automator-hurb` e o deixe disponível por pelo menos 30 dias. Ao terminar o desafio nos envie um email avisando do termino.
    -   Caso você tenha algum problema para criar o repositório privado, ao término do desafio preencha o arquivo chamado `pull-request.txt`, comprima a pasta do projeto - incluindo a pasta `.git` - e nos envie por email.
-   O código precisa rodar em Ubuntu ou centOS (preferencialmente como containers Docker)
-   Caso haja uma falha em um dos nós, o restante do cluster precisa continuar funcionando e os dados fluindo. (vamos remover um dos nós nos testes)
-   Quando o cluster voltar a ter 5 nós após uma falha, os dados devem ser resincronizados automaticamente. (vamos adicionar o um **novo** nó)
-   Para executar seu código, deve ser preciso apenas rodar os seguintes comandos:
    -   git clone \$seu-forkseu-fork
    -   comando para instalar dependências
    -   comando para executar a aplicação

## Critério de avaliação

-   **Organização do código**: Separação de módulos, view e model, back-end e front-end
-   **Clareza**: O README explica de forma resumida qual é o problema e como pode rodar a aplicação?
-   **Assertividade**: A aplicação está fazendo o que é esperado? Se tem algo faltando, o README explica o porquê?
-   **Legibilidade do código** (incluindo comentários)
-   **Segurança**: Existe alguma vulnerabilidade clara?
-   **Cobertura de testes** (Não esperamos cobertura completa)
-   **Histórico de commits** (estrutura e qualidade)
-   **Escolhas técnicas**: A escolha das bibliotecas, banco de dados, arquitetura, etc, é a melhor escolha para a aplicação?

## Dúvidas

Quaisquer dúvidas que você venha a ter, consulte as [_issues_](https://github.com/HurbCom/challenge-delta/issues) para ver se alguém já não a fez e caso você não ache sua resposta, abra você mesmo uma nova issue!

Boa sorte e boa viagem! ;)

<p align="center">
  <img src="ca.jpg" alt="Challange accepted" />
</p>
