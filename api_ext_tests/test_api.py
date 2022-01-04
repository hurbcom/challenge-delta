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

if __name__ == '__main__':
    pytest.main()
