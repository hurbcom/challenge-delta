# API REST CRUD

Projeto baseado no codigo da aplicaão [flaskcrudapi](https://github.com/paulodhiambo/flaskcrudapi)

## Todo API

### Model

```
{
  "id": <int>, (readonly , id da tarefa)
  "title": <string> (required for POST, titulo da tarefa),
  "todo_description": <string> (required for POST, descrição da tarefa)
}
```

### Endpoints

`GET /api/v1/todo`

Retorna todas as tarefas

* Exemplo de URL

```
http://localhost:5000/api/v1/todo
```

Exemplo de retorno com sucesso ( status code 200 )

```
{
  "todos": [
    {
      "id": 1,
      "title": "first task",
      "todo_description": "first description"
    },
    {
      "id": 2,
      "title": "second task",
      "todo_description": "second description"
    }
  ]
}
```

---

`GET /api/v1/todo/{id}`

Retorna os detalhes da tarefa com id <id>

* Exemplo de URL

```
http://localhost:5000/api/v1/todo/1
```

Exemplo de retorno com sucesso ( status code 200 )

```
{
  "todo": {
    "id": 1,
    "title": "get task",
    "todo_description": "get description"
  }
}
```

Exemplo de retorno com erro ( status code 404 )

```
{
  "errorText": "Invalid todo id 1a"
}
```

----

`POST /api/v1/todo`

Cria uma nova tarefa

* Exemplo de URL

```
http://localhost:5000/api/v1/todo
```

Exemplo de payload:

```
{
  "title": "sample task",
  "todo_description": "sample description"
}
```

Em caso de sucesso retorna o `id` da tarefa ( status code 200 )

```
1
```

Exemplo de retorno com erro ( status code 404 )

```
{
  "errorText": "Invalid title, cannot be null"
}
```

----

`PUT /api/v1/todo/{id}`

Atualiza a tarefa com id `id`

* Exemplo de URL

```
http://localhost:5000/api/v1/todo/1
```

Exemplo de payload:

```
{
  "title": "updated task",
  "todo_description": "updated description"
}
```

Em caso de sucesso retorna ( status code 200 ):

```
true
```

Exemplo de retorno com erro ( status code 404 )

```
{
  "errorText": "Invalid title, cannot be empty"
}
```

----

`DELETE /api/v1/todo/{id}`

Apaga a tarefa com id `id`
 
* Exemplo de URL

```
http://localhost:5000/api/v1/todo/1
```

Em caso de sucesso retorna ( status code 200 ):

```
true
```

Exemplo de retorno com erro ( status code 404 )

```
{
  "errorText": "todo with id 1 not found"
}
```
### Banco de dados MySQL

A propria aplicação da API cria a tabela `todos` no banco de dados MySQL `todo`

A estrutura da tabela é:

```
CREATE TABLE `todos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) DEFAULT NULL,
  `todo_description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2053 DEFAULT CHARSET=latin1
```

# Testes unitários

Requisitos: o framework [pytest](https://docs.pytest.org/).

Os testes usam um banco sqlite em memoria. A aplicação [app.py](api/app.py) irá criar a tabela antes de iniciar os testes.

Execução dos testes:

```bash
$ python3 -m pytest --disable-warnings -v api/test_api_unitary.py 
```

Para gerar o report em formato _JUnit-XML_:

```bash
$ python3 -m pytest --disable-warnings --junitxml results.xml test_api_unitary.py
```

Exemplo de resultados dos testes:

```bash
$ python3 -m pytest --disable-warnings -v api/test_api_unitary.py
===================================== test session starts ======================================
platform linux -- Python 3.9.7, pytest-6.0.2, py-1.10.0, pluggy-0.13.0 -- /usr/bin/python3
cachedir: .pytest_cache
rootdir: /home/ssorato/Documents/githublab/challenge-delta
collected 13 items                                                                             

api/test_api_unitary.py::apiUnitTests::test_delete PASSED                                [  7%]
api/test_api_unitary.py::apiUnitTests::test_get PASSED                                   [ 15%]
api/test_api_unitary.py::apiUnitTests::test_get_all PASSED                               [ 23%]
api/test_api_unitary.py::apiUnitTests::test_get_unexisting_id PASSED                     [ 30%]
api/test_api_unitary.py::apiUnitTests::test_get_wrong_id PASSED                          [ 38%]
api/test_api_unitary.py::apiUnitTests::test_post PASSED                                  [ 46%]
api/test_api_unitary.py::apiUnitTests::test_post_null_description PASSED                 [ 53%]
api/test_api_unitary.py::apiUnitTests::test_post_null_title PASSED                       [ 61%]
api/test_api_unitary.py::apiUnitTests::test_put PASSED                                   [ 69%]
api/test_api_unitary.py::apiUnitTests::test_put_empty_description PASSED                 [ 76%]
api/test_api_unitary.py::apiUnitTests::test_put_empty_title PASSED                       [ 84%]
api/test_api_unitary.py::apiUnitTests::test_put_null_description PASSED                  [ 92%]
api/test_api_unitary.py::apiUnitTests::test_put_null_title PASSED                        [100%]

=============================== 13 passed, 49 warnings in 0.42s ================================
```

# Rodar a aplicação no Minikube

1. Levantar o Minikube:

```bash
$ minikube start
```

2. Ativar as métricas:

```bash
$ minikube addons enable metrics-server
```

3. Reutulizar o docker daemon, para que possa ser utlizada a imagem docker local:

```bash
$ eval $(minikube docker-env) 
```

4. Executar o build da imagem docker com a API ( comandos executado a partir da pasta raiz do projeto ):

```bash
$ docker build ./api -t apicrud:v1
```

5. Executar o deploy ( comandos executado a partir da pasta raiz do projeto ):

```bash
$ kubectl apply -f k8s/
```

6. Verificar que os pods, serviço e hpa esteja ativos:

```bash
$ kubectl -n api get all
```

7. Testar a API ( o comando `jq` facilita a leitura do retorno )

```bash
$ curl -s `minikube -n api service api-crud --url`/api/v1/todo | jq
```

8. Para visualizar os logs da API executar o comando:

```bash
$ kubectl -n api logs -f -l app=api-crud
```

# Testar a API com o Postman

Importar a [collection](postman_collection.json)

Executar o comando:

```bash
$ minikube -n api service api-crud --url
```

e configurar as variaveis:

* `LB_IP` ip obtido pelo comando
* `LB_PORT` porta tcp obtida pelo comando

# Testar a API pelo acesso externo

Foram criados teste usando o mesmo framework dos testes unitários [pytest](https://docs.pytest.org/).

Executar o comando:

```bash
$ cd api_ext_tests; python3 test_api.py --cmdopt=`minikube -n api service api-crud --url`/api/v1 -v
```

Exemplo de resultado:

```
============================================ test session starts ============================================
platform linux -- Python 3.9.7, pytest-6.0.2, py-1.10.0, pluggy-0.13.0 -- /usr/bin/python3
cachedir: .pytest_cache
rootdir: /home/ssorato/Documents/githublab/challenge-delta/api_ext_tests
collected 12 items                                                                                          

test_api.py::test_get_all PASSED                                                                      [  8%]
test_api.py::test_get PASSED                                                                          [ 16%]
test_api.py::test_put PASSED                                                                          [ 25%]
test_api.py::test_delete PASSED                                                                       [ 33%]
test_api.py::test_get_wrong_id PASSED                                                                 [ 41%]
test_api.py::test_post_null_title PASSED                                                              [ 50%]
test_api.py::test_post_null_description PASSED                                                        [ 58%]
test_api.py::test_put_null_title PASSED                                                               [ 66%]
test_api.py::test_put_null_description PASSED                                                         [ 75%]
test_api.py::test_put_empty_title PASSED                                                              [ 83%]
test_api.py::test_put_empty_description PASSED                                                        [ 91%]
test_api.py::test_get_unexisting_id PASSED                                                            [100%]

============================================ 12 passed in 0.35s =============================================
```

