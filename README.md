## Projeto - desafio Hurb

    O objetivo da aplicação é fazer um consulta no banco mysql e exibir os registros do banco atraves da extensão /packages. Também se faz necessário comandos aux para deletar e criar novos registros.

    **Arquivos**:

    Os arquivos necessários para executar todo o ambiente, estão organizados nas seguintes pastas:

    ANSIBLE
    CONFIGS
    DATABASE
    DOCKERFILE 

    **Desenho Projeto**:

    O desenho do projeto está no arquivo desafio.png

    **Os problemas**:

    Na configuração do nodeJS foi encontrado erros na conexão do banco, no script de criação do banco foram encontrados erros de sintaxe que foram corrigidos ("database_schema.sql").

    **Segurança**:

    O script do banco apenas criava o banco e as tabelas, logo o banco não tinha senha no usuario root. O que é um falha de segurança grande, se apenas fosse executado o script ainda que estivesse funcionando sem erros ainda teriamos o problema do usuario root sem senha.

    **Aplicação**:

    A aplicação está fazendo o que foi solicitado, consulta ao banco, delete de registros e criação de novos dados.

    **Escolhas técnicas**:

    Utilizei o Ansible, Dockerfile e Docker-Compose. Ansible fica responsável por criar as imagens com o Dockerfile e Docker-compose, e subir todos os containers deixando a aplicação up.

    Comandos para subir o ambiente de forma automatizada.

    ansible-playbook /etc/ansible/playbook/imgs-container.yml && ansible-playbook /etc/ansible/playbook/container-start.yml

    **Comandos para API**:

    Para criar um registro novo no banco ou deletar se faz necessário os seguintes comandos:

    Criar:

    curl -X POST -d "text=registro1" http://192.168.15.12/create

    Deletar:
 
    curl -X DELETE -d "text=registro1" http://192.168.15.12/delete/1