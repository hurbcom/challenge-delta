from flask import Flask, request, jsonify, make_response
from flask_sqlalchemy import SQLAlchemy
from marshmallow import fields
from marshmallow_sqlalchemy import ModelSchema
import os, sys


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = os.environ['DB_URI']
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

try:
  db.engine.execute('SELECT 1')
  print("Database ready ...", file=sys.stdout)
except:
  print("Failed to connect to database; exiting ...", file=sys.stderr)
  exit(1)

# Model
class Todo(db.Model):
  __tablename__ = "todos"
  id = db.Column(db.Integer, primary_key=True)
  title = db.Column(db.String(20))
  todo_description = db.Column(db.String(100))

  def create(self):
    db.session.add(self)
    db.session.commit()
    return self

  def __init__(self, title, todo_description):
    self.title = title
    self.todo_description = todo_description

  def __repr__(self):
    return f"{self.id}"


# Create table "todos" if not exists
db.create_all()

# Model schema
class TodoSchema(ModelSchema):
  class Meta(ModelSchema.Meta):
    model = Todo
    sqla_session = db.session

  id = fields.Number(dump_only=True)
  title = fields.String(required=True)
  todo_description = fields.String(required=True)

#
# API endpoints
#

# k8s liveness probe 
@app.route('/health/live', methods=['GET'])
def health():
  return make_response("ok", 200)

# k8s readiness probe 
@app.route('/health/ready', methods=['GET'])
def readiness():
  try:
    db.engine.execute('SELECT 1')
    return make_response("ok", 200)
  except:
    return make_response("nok", 500)

# GET todos
@app.route('/api/v1/todo', methods=['GET'])
def index():
  get_todos = Todo.query.all()
  todo_schema = TodoSchema(many=True)
  todos = todo_schema.dump(get_todos) # Why dump returns a float ??
  return make_response(jsonify({"todos": todos}))

# GET todo
@app.route('/api/v1/todo/<id>', methods=['GET'])
def get_todo_by_id(id):
  if not id.isdigit():
    return make_response(jsonify({"errorText": "Invalid todo id %s" % id}), 400)
  get_todo = Todo.query.get(id)
  if get_todo is None:
    return make_response(jsonify({"errorText": "Can't find todo id %s" % id}), 404)
  else:
    todo_schema = TodoSchema()
    todo = todo_schema.dump(get_todo)  # Why dump returns a float ??
    todo["id"] = int(todo["id"])
    return make_response(jsonify({"todo": todo}))

# Update todo
@app.route('/api/v1/todo/<id>', methods=['PUT'])
def update_todo_by_id(id):
  if not id.isdigit():
    return make_response(jsonify({"errorText": "Invalid todo id %s" % id}), 400)
  data = request.get_json()
  get_todo = Todo.query.get(id)
  if get_todo is None:
    return make_response(jsonify({"errorText": "Can't find todo %s" % id}), 404)
  else:
    if "title" in data or "todo_description" in data:
      if "title" in data:
        if data.get('title') == "":
          return make_response(jsonify({"errorText": "Invalid title, cannot be empty"}), 400)
        else:
          get_todo.title = data['title']
      if "todo_description" in data:
        if data.get('todo_description') == "":
          return make_response(jsonify({"errorText": "Invalid todo_description, cannot be empty"}), 400)
        else:
            get_todo.todo_description = data['todo_description']      
    else:
      return make_response(jsonify({"errorText": "Both title and todo_description cannot be null"}), 400)
    db.session.add(get_todo)
    db.session.commit()
    todo_schema = TodoSchema(only=['id', 'title', 'todo_description'])
    todo = todo_schema.dump(get_todo)
    return make_response("true", 200)

# Delete todo
@app.route('/api/v1/todo/<id>', methods=['DELETE'])
def delete_todo_by_id(id):
  get_todo = Todo.query.get(id)
  if get_todo is None:
    return make_response(jsonify({"errorText": "todo with id %s not found" % id}), 404)
  else:
    db.session.delete(get_todo)
    db.session.commit()
    return make_response("true", 200)

# Create a new todo
@app.route('/api/v1/todo', methods=['POST'])
def create_todo():
  data = request.get_json()
  if not data.get('title'):
    return make_response(jsonify({"errorText": "Invalid title, cannot be null"}), 400)
  if not data.get('todo_description'):
    return make_response(jsonify({"errorText": "Invalid todo_description, cannot be null"}), 400)
  todo_schema = TodoSchema()
  todo = todo_schema.load(data)
  result = todo_schema.dump(todo.create())
  result["id"] = int(result["id"]) # Why dump returns a float ??
  return make_response(str(result["id"]), 201)


if __name__ == '__main__':
  app.run(host='0.0.0.0', port="5000", debug=False)
