# <img src="https://avatars1.githubusercontent.com/u/7063040?v=4&s=200.jpg" alt="HU" width="24" /> Desafio Delta

O projeto consiste em uma API implementada com Node.js​ + MySQL​ para criação e consulta de pacotes.
O mesmo está montado na estrutura  ( frontend, backend e database ) em 3 containers, com deploy do ambiente realizado através de Docker Compose:

-   1 container rodando a aplicação em Node.js;
-   1 container rodando um banco de dados MySQL;
-   1 container rodando um servidor nginx (reverse proxy);

## Deploy
-   Para executar a API são necessários:
    -   git clone do projeto
    -   no diretorio (challenge-delta) executar: docker-compose up -d
   
### API Calls

* **Lista todos os pacotes**
   -   /packages

* **Method:**

   `GET`
  
*  **URL Params**
   None

* **Data Params**
   None

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `[{"Id":1,"Text":"`pacote_url` = 'pacote 2'","CreateDate":"2020-05-18T18:39:01.000Z"}]`

* **Adiciona um novo Pacote**
   -   /packages
   
* **Method:**

  `POST`

* **Body Request**
    
    - { package : "Package example" }

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{Ok}`
 
* **Error Response:**

  * **Code:** 400 BAD REQUEST <br />
    **Content:** `{"message": "texto inválido"}`

* **Deleta um pacote existente**
   -   /packages
   
* **Method:**

  `DELETE`

* **URL Params**
    
   **Required:**
 
   `id=[integer]`

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{Ok}`
 
* **Error Response:**

  * **Code:** 400 BAD REQUEST <br />
    **Content:** `{"message": "id inválido"}`
