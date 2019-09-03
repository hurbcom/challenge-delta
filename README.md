
# <img src="https://avatars1.githubusercontent.com/u/7063040?v=4&s=200.jpg" alt="HU" width="24" /> Desafio Delta - Gustavo Martins

Apresenta a solução para o **Desafio Delta**, proposto pela HURB , a solução foi desenvolvida por Gustavo Martins.

A intenção é demonstrar conhecimento, capacidade lógica e técnica para atuar nas necessidades reais portanto as soluções adotadas **não foram propostas para ambientes produtivos**  e nem mesmo representam a total capacidade de arquitetura de soluções, apenas apresentam um esboço de recursos simplificados para avaliação.

## Topologia

![Topologia básica](https://raw.githubusercontent.com/GuguRD/challenge-delta/challenge/challenge-topology.jpg)
### Descrição e considerações
A solução foi divida usando o modelo 3-Tier (Presentation, Application, Data) dentro de um cluster Kubernetes com o minikube versão 1.3.1 como cluster. O deploy e configuração dos containers foi feita através de arquivo YAML (.yml) disponibilizado na pasta "deploy" de cada Tier e as senhas de acesso ao banco usam variáveis de ambiente e o recurso Secrets do Kubernetes.

 - **Presentation** (Apresentação):
	 - Optei por usar [NGINX Ingress Controller](https://github.com/kubernetes/ingress-nginx) provido pela Kubernetes, dessa forma o Cluster pode gerenciar de forma automática o endereçamento e balançeamento entre os recursos da aplicação, permitindo um rápido deploy e baixa manutenção.
	 - O recurso está disponível na porta 80 do endereço do Cluster.
	 - Porta 443 disponivel mas o redirect para essa porta está desativado para atender o desafio.
	 - Considerei que a estrutura e dados do banco de dados é de responsabilidade da aplicação
 - **Application** (Aplicação)
	 - A aplicação usa nodejs e para atender criei uma imagem Docker, usando o Dockerfile dispónivel na pasta da aplicação e hospedei publicamente.
	 - A imagem Docker escolhida usa a versão 12.9.1 do nome em uma distribuição Alpine Linux disponibilizada oficialmente pelos manutenadores do nodejs.
	 - O imagem já inclui os pacotes necessários para a aplicação rodar e foi necessário adicionar o Python 2.7, make (gcc) e mysql-client para atender aos requisitos da aplicação.
	 - Foi incluido um breve teste usando HTTP GET usando Kubernetes Probes para validar disponibilidade da aplicação.
 - **Data** (Dados)
	 - Foi escolhido o MySQL 5.7 por ser OpenSource, de prática disponiblização e compativel com a aplicação para isso usamos a imagem Docker também disponibilizada oficialmente.
	 - O usuário e senha padrão do banco é definido nos Secrets do Kubernetes durante o deploy.
	 - A instância de banco **não** fica disponivel para acesso fora do cluster Kubernetes.
	 - Desempenho e disponibilidade da instância de banco de dados é de responsabilidade desse Tier

## Requisitos para execução

Considerando que o ambiente a rodar a aplicação já tem pre-configurado o minikube (1.3.1) e kubectl os seguintes passos são necessários (apesar de agnóstico utilizei um ambiente Linux para o desafio):

**Instalação manual:**
 1. Clonar esse repositório:

> `git clone https://github.com/GuguRD/challenge-delta.git`

 2. Criar os "Secrets" para o Kubernetes:


>`kubectl create secret generic mysql-root-pass --from-literal=password=ROOT_PASS`
>
>`kubectl create secret generic mysql-user-pass --from-literal=username=APP_USER --from-literal=password=APP_PASS`
>
>`kubectl create secret generic mysql-db-name --from-literal=database=packages`

 3. Aplicar os arquivos .yml no cluster Kubernetes:
 >`kubectl apply -f ./application/deploy/app.yml`
 >
 >`kubectl apply -f ./data/deploy/mysql.yml`
 >
 >`kubectl apply -f ./presentation/deploy/nginx-ingress.yml`
 
 
4. Importar schema de banco de dados:
>`APP_POD=$(kubectl get pod -l app=nodejs-app-server -o jsonpath="{.items[0].metadata.name}")`
>
>`kubectl exec -i $APP_POD -- mysql -h nodejs-app-mysql -u APP_USER -pAPP_PASS packages <./application/nodejs/database_schema.sql`

**Instalação automática** (Apenas para BASH/Linux)
Disponibilizei um script de deploy automático para o BASH
>`./deploy.sh deploy`  -- Faz o deploy completo interativo

>`./deploy.sh update`  -- Apenas atualiza o deploy Kubernetes

>`./deploy.sh db_import` -- Apenas importa o banco de dados (./application/nodejs/database_schema.sql) 

## Mudanças e comentários

-   **Organização do código**: Formatado em 3-Tier, com separação de deploy e código
-   **Clareza**: Tentei ser breve nos detalhes mas acredito que o Readme atende o quisito
-   **Assertividade**: Apesar de não ficar claro o que a aplicação deve fazer, testes com curl tiveram sucesso
-   **Legibilidade do código** Com excessão do script de Deploy todos os arquivos incluídos foram comentados e explicados em comentários do commit
-   **Segurança**: Sim, mas por ser um sandbox/desafio desconsiderei esse quisito mas um exemplo é validação de post pela API (Injection) e a ausência de HTTPS.
-   **Cobertura de testes** Apenas inclui uma checagem na aplicação de conexão com o banco e falta de variável de ambiente como conceito de conhecimento
-   **Histórico de commits** Todos feitos em inglês com detalhes básicos
-   **Escolhas técnicas**: Seguindo as exigências do teste usei o que há de tendência no mercado

Atenciosamente,
Gustavo Martins
