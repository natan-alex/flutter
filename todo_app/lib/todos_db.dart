import 'package:todo_app/todo_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'crud.dart';

class TodosDb implements CRUD<TodoItem, int> {
  Database? _database;

  TodosDb._();
  static final TodosDb instance = TodosDb._();

  Future _initializeDatabase() async {
    if (_database == null) {
      var databasePath = await getDatabasesPath();
      databasePath = path.join(databasePath, 'todos.db');

      _database = await openDatabase(databasePath,
          version: 1, onCreate: _createTodosTable);
    }
  }

  void _createTodosTable(Database database, int version) {
    database.execute('''CREATE TABLE Todos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      description VARCHAR(50) NOT NULL,
      isDone BOOLEAN NOT NULL
    );''');
  }

  @override
  Future<List<TodoItem>> getAllItems() async {
    await _initializeDatabase();

    var databaseItems = await _database!.rawQuery('SELECT * FROM Todos');
    List<TodoItem> todos = List.empty(growable: true);

    for (var item in databaseItems) {
      todos.add(TodoItem.fromMap(item));
    }

    return todos;
  }

  @override
  Future createItem(TodoItem newItem) async {
    await _initializeDatabase();

    await _database!.rawInsert('''
      INSERT INTO Todos(description, isDone) VALUES(?, ?);
    ''', [newItem.description, newItem.isDone]);
  }

  @override
  Future<bool> deleteItemById(int id) async {
    await _initializeDatabase();

    return await _database!.rawDelete('''
      DELETE FROM Todos WHERE id = ?;
    ''', [id]) > 0;
  }

  @override
  Future<TodoItem?> getItemById(int id) async {
    await _initializeDatabase();

    var todosAsMap =
        await _database!.rawQuery('SELECT * FROM Todos WHERE id = ?', [id]);

    return todosAsMap.isNotEmpty ? TodoItem.fromMap(todosAsMap.first) : null;
  }

  @override
  Future<bool> updateItem(int id, TodoItem newItem) async {
    await _initializeDatabase();

    return await _database!.rawUpdate('''
      UPDATE Todos SET description = ?, isDone = ?
      WHERE id = ?''', [newItem.description, newItem.isDone ? 1 : 0, id]) > 0;
  }
}
