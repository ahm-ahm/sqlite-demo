import 'package:db_final/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  //Create a private constructor THAT CAN BE NAMED CONSTRUCTOR
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
  static const DATABASE_NAME = 'todos_database.db';
  static const DATABASE_VERSION = 1;
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), DATABASE_NAME),
        version: DATABASE_VERSION, onCreate: (Database db, int version) async {
      await db.execute(
        Todo.CREATE_TABLE,
      );
    });
  }

  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    var res = await db.insert(Todo.TABLE_TODO, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return res;
  }

  Future<List<Todo>> retrieveTodos() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(Todo.TABLE_TODO);

    return List.generate(maps.length, (todoOjb) {
      return Todo(
        id: maps[todoOjb][Todo.COL_ID],
        title: maps[todoOjb][Todo.COL_NAME],
        description: maps[todoOjb][Todo.COL_DESCRIPTION],
      );
    });
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await database;

    int res = await db.update(Todo.TABLE_TODO, todo.toMap(),
        where: '${Todo.COL_ID} = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('the id =${Todo.COL_ID} and where id =${todo.id}');
    res == 1 ? print('successful updation') : print('unsuccessful updation');
    return res;
  }

  Future<int> deleteTodo(int id) async {
    var db = await database;
    int res = await db
        .delete(Todo.TABLE_TODO, where: '${Todo.COL_ID} = ?', whereArgs: [id]);

    return res;
  }
}
