import pytest
import requests

def test_get_all(cmdopt):
  header = {
    "Accept": "*/*",
    "User-Agent": "request"
  }

  url = cmdopt + "/todo"

  response = requests.get(url,headers=header)
  status = response.status_code

  if status == 200:
    data = response.json()
    todoCount = len(data["todos"])
    assert todoCount >= 0, "todo count %d is not greater or equal than 0" % todoCount
  else:
    assert False, "status code %d is not 200" % status

def test_get(cmdopt):
  header = {
    "Content-Type": "application/json",
    "User-Agent": "request"
  }

  url = cmdopt + "/todo"
  payload = {
    "title": "get task",
    "todo_description": "get description"
  }

  response = requests.post(url, headers=header, json=payload)
  status = response.status_code

  if status == 201:
    data = response.json()
    if type(data) == int and data > 0:
      url = cmdopt + "/todo/" + str(data)
      response = requests.get(url, headers=header)
      status = response.status_code
      if status == 200:
        dataGet = response.json()
        assert dataGet["todo"]["id"] == data and dataGet["todo"]["title"] == "get task" and dataGet["todo"]["todo_description"] == "get description", "Wrong result %s" % dataGet
      else:
        assert False, "status code %d is not 200" % status
    else:
      assert False, "todo index %s is not integer or is not greater than 0" % data
  else:
    assert False, "status code %d is not 201" % status


def test_put(cmdopt):
  header = {
    "Content-Type": "application/json",
    "User-Agent": "request"
  }

  url = cmdopt + "/todo"
  payload = {
    "title": "test put",
    "todo_description": "put description"
  }

  response = requests.post(url, headers=header, json=payload)
  status = response.status_code

  if status == 201:
    data = response.json()
    if type(data) == int and data > 0:
      url = cmdopt + "/todo/" + str(data)
      response = requests.get(url, headers=header)
      status = response.status_code
      if status == 200:
        dataGet = response.json()
        assert dataGet["todo"]["id"] == data and dataGet["todo"]["title"] == "test put" and dataGet["todo"]["todo_description"] == "put description", "Wrong result %s" % dataGet
    else:
      assert False, "todo index %s is not integer or is not greater than 0" % data
  else:
    assert False, "status code %d is not 201" % status

def test_put(cmdopt):
  header = {
    "Content-Type": "application/json",
    "User-Agent": "request"
  }

  url = cmdopt + "/todo"
  payload = {
    "title": "test put",
    "todo_description": "put description"
  }

  response = requests.post(url, headers=header, json=payload)
  status = response.status_code

  if status == 201:
    data = response.json()
    if type(data) == int and data > 0:
      url = cmdopt + "/todo/" + str(data)
      payload = {
        "title": "test put modified",
        "todo_description": "put description"
      }
      response = requests.put(url, headers=header, json=payload)
      status = response.status_code
      if status == 200:
        dataPut = response.text
        assert dataPut == "true", "Put result %s is not true" % dataPut
    else:
      assert False, "todo index %s is not integer or is not greater than 0" % data
  else:
    assert False, "status code %d is not 201" % status


def test_delete(cmdopt):
  header = {
    "Content-Type": "application/json",
    "User-Agent": "request"
  }

  url = cmdopt + "/todo"
  payload = {
    "title": "test delete",
    "todo_description": "delete description"
  }

  response = requests.post(url, headers=header, json=payload)
  status = response.status_code

  if status == 201:
    data = response.json()
    if type(data) == int and data > 0:
      url = cmdopt + "/todo/" + str(data)
      response = requests.delete(url, headers=header)
      status = response.status_code
      if status == 200:
        dataDelete = response.text
        assert dataDelete == "true", "Delete result %s is not true" % dataDelete
    else:
      assert False, "todo index %s is not integer or is not greater than 0" % data
  else:
    assert False, "status code %d is not 201" % status


def test_get_wrong_id(cmdopt):
  header = {
    "Content-Type": "application/json",
    "User-Agent": "request"
  }

  url = cmdopt + "/todo/1wrongid"

  response = requests.get(url, headers=header)
  status = response.status_code

  if status == 400:
    data = response.json()
    assert data["errorText"] == "Invalid todo id 1wrongid", "Wrong '%s' response" % data["errorText"]
  else:
    assert False, "Received status code %d instead of 400" % status

def test_post_null_title(cmdopt):
  header = {
    "Content-Type": "application/json",
    "User-Agent": "request"
  }

  url = cmdopt + "/todo"
  payload = {
    "todo_description": "put description"
  }

  response = requests.post(url, headers=header, json=payload)
  status = response.status_code

  if status == 400:
    data = response.json()
    assert data["errorText"] == "Invalid title, cannot be null", "Wrong '%s' response" % data["errorText"]
  else:
    assert False, "Received status code %d instead of 400" % status

def test_post_null_description(cmdopt):
  header = {
    "Content-Type": "application/json",
    "User-Agent": "request"
  }

  url = cmdopt + "/todo"
  payload = {
    "title": "post without description"
  }

  response = requests.post(url, headers=header, json=payload)
  status = response.status_code

  if status == 400:
    data = response.json()
    assert data["errorText"] == "Invalid todo_description, cannot be null", "Wrong '%s' response" % data["errorText"]
  else:
    assert False, "Received status code %d instead of 400" % status

def test_put_null_title(cmdopt):
  header = {
    "Content-Type": "application/json",
    "User-Agent": "request"
  }

  url = cmdopt + "/todo"
  payload = {
    "title": "test put",
    "todo_description": "put description"
  }

  response = requests.post(url, headers=header, json=payload)
  status = response.status_code

  if status == 201:
    data = response.json()
    if type(data) == int and data > 0:
      url = cmdopt + "/todo/" + str(data)
      payload = {
        "todo_description": "put without title"
      }
      response = requests.put(url, headers=header, json=payload)
      status = response.status_code
      if status == 200:
        dataPut = response.text
        assert dataPut == "true", "Put result %s is not true" % dataPut
      else:
        assert False, "Received status code %d instead of 200" % status
    else:
      assert False, "todo index %s is not integer or is not greater than 0" % data
  else:
    assert False, "status code %d is not 201" % status


def test_put_null_description(cmdopt):
  header = {
    "Content-Type": "application/json",
    "User-Agent": "request"
  }

  url = cmdopt + "/todo"
  payload = {
    "title": "test put",
    "todo_description": "put description"
  }

  response = requests.post(url, headers=header, json=payload)
  status = response.status_code

  if status == 201:
    data = response.json()
    if type(data) == int and data > 0:
      url = cmdopt + "/todo/" + str(data)
      payload = {
        "todo_description": "put description modified"
      }
      response = requests.put(url, headers=header, json=payload)
      status = response.status_code
      if status == 200:
        dataPut = response.text
        assert dataPut == "true", "Put result %s is not true" % dataPut
      else:
        assert False, "Received status code %d instead of 200" % status
    else:
      assert False, "todo index %s is not integer or is not greater than 0" % data
  else:
    assert False, "status code %d is not 201" % status
    
def test_put_empty_title(cmdopt):
  header = {
    "Content-Type": "application/json",
    "User-Agent": "request"
  }

  url = cmdopt + "/todo"
  payload = {
    "title": "test post",
    "todo_description": "post description"
  }

  response = requests.post(url, headers=header, json=payload)
  status = response.status_code

  if status == 201:
    data = response.json()
    if type(data) == int and data > 0:
      url = cmdopt + "/todo/" + str(data)
      payload = {
        "title": "",
        "todo_description": "post without title"
      }
      response = requests.put(url, headers=header, json=payload)
      status = response.status_code
      if status == 400:
        data = response.json()
        assert data["errorText"] == "Invalid title, cannot be empty", "Wrong '%s' response" % data["errorText"]
      else:
        assert False, "Received status code %d instead of 400" % status
    else:
      assert False, "todo index %s is not integer or is not greater than 0" % data
  else:
    assert False, "status code %d is not 201" % status

def test_put_empty_description(cmdopt):
  header = {
    "Content-Type": "application/json",
    "User-Agent": "request"
  }

  url = cmdopt + "/todo"
  payload = {
    "title": "test post",
    "todo_description": "post description"
  }

  response = requests.post(url, headers=header, json=payload)
  status = response.status_code

  if status == 201:
    data = response.json()
    if type(data) == int and data > 0:
      url = cmdopt + "/todo/" + str(data)
      payload = {
        "title": "post tilte",
        "todo_description": ""
      }
      response = requests.put(url, headers=header, json=payload)
      status = response.status_code
      if status == 400:
        data = response.json()
        assert data["errorText"] == "Invalid todo_description, cannot be empty", "Wrong '%s' response" % data["errorText"]
      else:
        assert False, "Received status code %d instead of 400" % status
    else:
      assert False, "todo index %s is not integer or is not greater than 0" % data
  else:
    assert False, "status code %d is not 201" % status

def test_get_unexisting_id(cmdopt):
  header = {
    "Content-Type": "application/json",
    "User-Agent": "request"
  }

  url = cmdopt + "/todo/30000"

  response = requests.get(url, headers=header)
  status = response.status_code

  if status == 404:
    data = response.json()
    assert data["errorText"] == "Can't find todo id 30000", "Wrong '%s' response" % data["errorText"]
  else:
    assert False, "Received status code %d instead of 404" % status


if __name__ == '__main__':
    pytest.main()
