import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database ? _database;

  factory DatabaseHelper(){
    return _instance;
  }
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(),'tasker.db');
    return await openDatabase(
        path,
      version: 1,
      onCreate: (db,version){
          return db.execute(
            "CREATE TABLE tasks("
                "id INTEGER PRIMARY KEY,"
                "title TEXT,"
                "content TEXT,"
                "priority TEXT,"
                "color TEXT,"
                "dueDate TEXT,"
                "createdAt TEXT,"
                "updatedAt TEXT,"
                "userId INTEGER"
                ")",
          );
      },
    );
  }
  Future<void> insertTask(Map<String,dynamic> task) async{
    final db = await database;
    await db.insert('tasks', task,conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<List<Map<String,dynamic>>> getTasks() async {
    final db = await database;
    return await db.query('tasks');
  }
  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete('tasks',where: "id = ?",whereArgs: [id]);
  }
}
