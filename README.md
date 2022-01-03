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
