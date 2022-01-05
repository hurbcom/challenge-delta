import unittest
import os

os.environ["DB_URI"] = "sqlite:///:memory:"

from app import app, db, TodoSchema

class apiUnitTests(unittest.TestCase):
  def setUp(self):
    """
    Creates a new database for the unit test to use
    """
    self.app = app
    db.init_app(self.app)
    with self.app.app_context():
        db.create_all()
        todo_schema = TodoSchema()
        data = {"title": "title 1", "todo_description": "description 1"}
        todo = todo_schema.load(data)
        todo_schema.dump(todo.create())
        data = {"title": "title 2", "todo_description": "description 2"}
        todo = todo_schema.load(data)
        todo_schema.dump(todo.create())
        data = {"title": "title 3", "todo_description": "description 3"}
        todo = todo_schema.load(data)
        todo_schema.dump(todo.create())

  def tearDown(self):
    db.session.remove()
    db.drop_all()

  def test_get_all(self):
    tester = app.test_client(self)
    r = tester.get("/api/v1/todo")
    status = r.status_code
    if status == 200:
      data = r.json
      todoCount = len(data["todos"])
      assert todoCount == 3, "todo count %d is not greater or equal than 0" % todoCount
    else:
      assert False, "status code %d is not 200" % status

  def test_get(self):
    tester = app.test_client(self)
    r = tester.get("/api/v1/todo/2")
    status = r.status_code
    if status == 200:
      dataGet = r.json
      assert dataGet["todo"]["id"] == 2 and dataGet["todo"]["title"] == "title 2" and dataGet["todo"]["todo_description"] == "description 2", "Wrong result %s" % dataGet
    else:
      assert False, "status code %d is not 200" % status

  def test_put(self):
    tester = app.test_client(self)
    payload = {
      "title": "title 2",
      "todo_description": "description 2 modified"
    }
    r = tester.put("/api/v1/todo/2", json=payload)
    status = r.status_code
    if status == 200:
      r = tester.get("/api/v1/todo/2")
      status = r.status_code
      if status == 200:
        dataGet = r.json
        assert dataGet["todo"]["id"] == 2 and dataGet["todo"]["title"] == "title 2" and dataGet["todo"]["todo_description"] == "description 2 modified", "Wrong result %s" % dataGet
      else:
        assert False, "status code %d is not 200" % status
    else:
      assert False, "status code %d is not 200" % status

  def test_delete(self):
    tester = app.test_client(self)
    r = tester.delete("/api/v1/todo/3")
    status = r.status_code
    if status == 200:
      r = tester.get("/api/v1/todo/3")
      status = r.status_code
      assert status == 404, "status code %d is not 200" % status
    else:
      assert False, "status code %d is not 200" % status

  def test_post(self):
    tester = app.test_client(self)
    payload = {
      "title": "title 4",
      "todo_description": "description 4"
    }
    r = tester.post("/api/v1/todo", json=payload)
    status = r.status_code
    if status == 201:
      dataPost = r.data.decode("utf-8")
      if type(dataPost) == str and int(dataPost) > 0:
        r = tester.get("/api/v1/todo/" + dataPost)
        status = r.status_code
        if status == 200:
          dataGet = r.json
          assert dataGet["todo"]["id"] == 4 and dataGet["todo"]["title"] == "title 4" and dataGet["todo"]["todo_description"] == "description 4", "Wrong result %s" % dataGet
        else:
          assert False, "Get status code %d is not 200" % status
      else:
        assert False, "Post result %s is not an integer greater than 0" % dataPost
    else:
      assert False, "Post status code %d is not 201" % status

  def test_get_wrong_id(self):
    tester = app.test_client(self)
    r = tester.get("/api/v1/todo/2a")
    status = r.status_code
    if status == 400:
      dataGet = r.json
      assert dataGet["errorText"] == "Invalid todo id 2a", "Wrong '%s' response" % dataGet["errorText"]
    else:
      assert False, "status code %d is not 400" % status

  def test_post_null_title(self):
    tester = app.test_client(self)
    payload = {
      "todo_description": "description 4 null title"
    }
    r = tester.post("/api/v1/todo", json=payload)
    status = r.status_code
    if status == 400:
      dataPost = r.json
      assert dataPost["errorText"] == "Invalid title, cannot be null", "Wrong '%s' response" % dataPost["errorText"]
    else:
      assert False, "Received status code %d instead of 400" % status

  def test_post_null_description(self):
    tester = app.test_client(self)
    payload = {
      "title": "title 4 null description"
    }
    r = tester.post("/api/v1/todo", json=payload)
    status = r.status_code
    if status == 400:
      dataPost = r.json
      assert dataPost["errorText"] == "Invalid todo_description, cannot be null", "Wrong '%s' response" % dataPost["errorText"]
    else:
      assert False, "Received status code %d instead of 400" % status


  def test_put_null_title(self):
    tester = app.test_client(self)
    r = tester.get("/api/v1/todo/3")
    status = r.status_code
    if status == 200:
      dataOriginal = r.json
      payload = {
        "todo_description": "description 3 with same title"
      }
      r = tester.put("/api/v1/todo/3", json=payload)
      status = r.status_code
      if status == 200:
        r = tester.get("/api/v1/todo/3")
        status = r.status_code
        if status == 200:
          dataGet = r.json
          assert dataGet["todo"]["id"] == dataOriginal["todo"]["id"] and dataGet["todo"]["title"] == dataOriginal["todo"]["title"] and dataGet["todo"]["todo_description"] == "description 3 with same title", "Wrong result %s" % dataGet
        else:
          assert False, "status code %d is not 200" % status
      else:
        assert False, "status code %d is not 200" % status
    else:
      assert False, "status code %d is not 200" % status

  def test_put_null_description(self):
    tester = app.test_client(self)
    r = tester.get("/api/v1/todo/3")
    status = r.status_code
    if status == 200:
      dataOriginal = r.json
      payload = {
        "title": "title 3 with same description"
      }
      r = tester.put("/api/v1/todo/3", json=payload)
      status = r.status_code
      if status == 200:
        r = tester.get("/api/v1/todo/3")
        status = r.status_code
        if status == 200:
          dataGet = r.json
          assert dataGet["todo"]["id"] == dataOriginal["todo"]["id"] and dataGet["todo"]["title"] == "title 3 with same description" and dataGet["todo"]["todo_description"] == dataOriginal["todo"]["todo_description"], "Wrong result %s" % dataGet
        else:
          assert False, "status code %d is not 200" % status
      else:
        assert False, "status code %d is not 200" % status
    else:
      assert False, "status code %d is not 200" % status

  def test_get_unexisting_id(self):
    tester = app.test_client(self)
    r = tester.get("/api/v1/todo/20000")
    status = r.status_code
    if status == 404:
      data = r.json
      assert data["errorText"] == "Can't find todo id 20000", "Wrong '%s' response" % data["errorText"]
    else:
      assert False, "status code %d is not 404" % status

  def test_put_empty_title(self):
    tester = app.test_client(self)
    payload = {
      "title": "",
      "todo_description": "description 1 with empty title"
    }
    r = tester.put("/api/v1/todo/1", json=payload)
    status = r.status_code
    if status == 400:
      data = r.json
      assert data["errorText"] == "Invalid title, cannot be empty", "Wrong '%s' response" % data["errorText"]
    else:
      assert False, "status code %d is not 400" % status

  def test_put_empty_description(self):
    tester = app.test_client(self)
    payload = {
      "title": "title 1",
      "todo_description": ""
    }
    r = tester.put("/api/v1/todo/1", json=payload)
    status = r.status_code
    if status == 400:
      data = r.json
      assert data["errorText"] == "Invalid todo_description, cannot be empty", "Wrong '%s' response" % data["errorText"]
    else:
      assert False, "status code %d is not 400" % status

if __name__ == '__main__':
  unittest.main()
