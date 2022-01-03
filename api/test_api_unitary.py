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


if __name__ == '__main__':
  unittest.main()
