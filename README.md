# <img src="https://avatars1.githubusercontent.com/u/7063040?v=4&s=200.jpg" alt="HU" width="24" /> Desafio Delta

Como DevOps voce vai desenhar e implementar arquitetura e sistemas relacionados a build, release, deploy e configurações de aplicações, assim como manter-se atualizado com as tecnologias de mercado.

Este estudo de caso tem como objetivo testar as habilidades relevantes para esta função. Por favor leia todas as instruções e responda todas as questões.

O projeto consiste em uma API implementada com Node.js​ + MySQL​ para criação e consulta de pacotes.
Você deve:

-   Criar o diagrama de toda a infraestrutura do projeto em questão ( frontend, backend e database );
    -   Montar toda a infraestrutura utilizando Docker:
        -   1 container rodando a aplicação em Node.js;
        -   1 container rodando um banco de dados MySQL;
        -   1 container rodando um servidor nginx;
-   Rodar a aplicação frontend na porta 80 e colocar o nginx ​como reverse proxy. O unico path disponivel deve ser o /packages, todos os demais paths devem ser redirecionados para o path default;
-   Preparar o banco de dados para ser usado pela aplicação;
-   Fornecer comandos para criação e inicialização do ambiente de forma automatizada
    -   (**diferencial**) Usar minikube ( utilizando kubectl )
-   Fornecer os comandos necessário para criar e deletar os pacotes;
-   Todos os logs ( access e error ) devem estar diponiveis via "docker logs".

## Requisitos

-   Forkar esse desafio e criar o seu projeto (ou workspace) usando a sua versão desse repositório, tão logo acabe o desafio, submeta um _pull request_.
    -   Caso você tenha algum motivo para não submeter um _pull request_, crie um repositório privado no Github, faça todo desafio na branch **master** e não se esqueça de preencher o arquivo `pull-request.txt`. Tão logo termine seu desenvolvimento, adicione como colaborador o usuário `automator-hurb` no seu repositório e o deixe disponível por pelo menos 30 dias. **Não adicione o `automator-hurb` antes do término do desenvolvimento.**
    -   Caso você tenha algum problema para criar o repositório privado, ao término do desafio preencha o arquivo chamado `pull-request.txt`, comprima a pasta do projeto - incluindo a pasta `.git` - e nos envie por email.
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
