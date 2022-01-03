from flask import Flask, request, jsonify, make_response
from flask_sqlalchemy import SQLAlchemy
from marshmallow import fields
from marshmallow_sqlalchemy import ModelSchema

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost:3306/todo'
db = SQLAlchemy(app)


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


db.create_all()


class TodoSchema(ModelSchema):
    class Meta(ModelSchema.Meta):
        model = Todo
        sqla_session = db.session

    id = fields.Number(dump_only=True)
    title = fields.String(required=True)
    todo_description = fields.String(required=True)


@app.route('/api/v1/todo', methods=['GET'])
def index():
    get_todos = Todo.query.all()
    todo_schema = TodoSchema(many=True)
    todos = todo_schema.dump(get_todos)
    return make_response(jsonify({"todos": todos}))


@app.route('/api/v1/todo/<id>', methods=['GET'])
def get_todo_by_id(id):
    get_todo = Todo.query.get(id)
    todo_schema = TodoSchema()
    todo = todo_schema.dump(get_todo)
    return make_response(jsonify({"todo": todo}))


@app.route('/api/v1/todo/<id>', methods=['PUT'])
def update_todo_by_id(id):
    data = request.get_json()
    get_todo = Todo.query.get(id)
    if data.get('title'):
        get_todo.title = data['title']
    if data.get('todo_description'):
        get_todo.todo_description = data['todo_description']
    db.session.add(get_todo)
    db.session.commit()
    todo_schema = TodoSchema(only=['id', 'title', 'todo_description'])
    todo = todo_schema.dump(get_todo)
    return make_response(jsonify({"todo": todo}))


@app.route('/api/v1/todo/<id>', methods=['DELETE'])
def delete_todo_by_id(id):
    get_todo = Todo.query.get(id)
    db.session.delete(get_todo)
    db.session.commit()
    return make_response("", 204)


@app.route('/api/v1/todo', methods=['POST'])
def create_todo():
    data = request.get_json()
    todo_schema = TodoSchema()
    todo = todo_schema.load(data)
    result = todo_schema.dump(todo.create())
    return make_response(jsonify({"todo": result}), 200)


if __name__ == "__main__":
    app.run(debug=True)