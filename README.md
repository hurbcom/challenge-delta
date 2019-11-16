
# <img src="https://avatars1.githubusercontent.com/u/7063040?v=4&s=200.jpg" alt="HU" width="24" /> Desafio Delta - Mauricio Gomes 11/2019

Prezados,
Segue meu desafio concluido, pensei em realizar em K8S porem não me senti confortavel para realizar com os meus conhecimentos atuais.

Estrutura de Pastas e Arquivos:
```
│   .editorconfig 
│   .gitignore 
│   ca.jpg
│   destroy_env.sh
│   pull-request.txt
│   README.md
│   start_env.sh
│   stop_env.sh
│
└───env
    │   diagram.pdf
    │   docker-compose.yaml
    │
    ├───db
    │   └───schema
    │           database_schema.sql
    │
    ├───nginx
    │   ├───conf
    │   │       default.conf
    │   │
    │   └───html
    │           50x.html
    │           index.html
    │
    └───node
            Dockerfile
            package.json
            server.js
```
Pre-Requisitos:

    Linux:
        Distribuição Linux com kernel 3.10 ou superior
        Processador com virtualização habilitada na bios
        Docker-CE
        Docker-Compose
    
    MacOs:
        Mac 2010 ou superior
        Processador com virtualização habilitada na bios
        Docker Tool Box
    
    Windows:
        Windows 8/10 Pro
        Hyper-V
        Processador com virtualização habilitada na bios
        Docker Desktop
        Git Bash

Ambiente:

    Iniciar o Ambiente:
        Execute start_env.sh *, o ambiente será criado e o banco será populado.

    Encerrar o Ambiente:
        Execute stop_env.sh *, o ambiente será encerrado, os dados do banco permanecerão.
    
    Destruir o Ambiente:
        Execute destroy_env.sh *, o ambiente será encerrado e os dados do banco serão excluidos.

    * Caso esteja executando no Windows utilize a Bash do Git para executar os comandos informados.

Logs:
    Os logos estão disponiveis em docker logs $nomedocontainer.
        
            docker logs hurb_nginx
            docker logs hurb_node
            docker logs hurb_mysql

Dados de Acesso ao banco:

    Banco: packages
    Usuário Root: root
    Senha Root: hurb_root
    Usuário da Aplicação: user_packages
    Senha da aplicação: passwords
    Acesso: localhost ou ip do servidor
    Porta: 3306
    
    * Mantive o acesso ao banco externamente, porem caso não queria disponibilizar a linha 14 e 15 do ./env/docker-compose.yaml devem ser comentadas

Considerações Finais:
    Realizei algumas mudanças na estrutura de pastas para melhor e organizar a aplicação.
    Achei bem interessante o desafio.
    Obrigado pela oportunidade.

