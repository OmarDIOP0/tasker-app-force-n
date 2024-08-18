import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'NotificationModel.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasker.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY,
        title TEXT,
        content TEXT,
        priority TEXT,
        color TEXT,
        dueDate TEXT,
        createdAt TEXT,
        updatedAt TEXT,
        userId INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE notifications(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        scheduledTime TEXT
      )
    ''');
  }

  Future<void> insertTask(Map<String, dynamic> task) async {
    final db = await database;
    await db.insert('tasks', task, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    return await db.query('tasks');
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete('tasks', where: "id = ?", whereArgs: [id]);
  }

  Future<int> insertNotification(NotificationModel notification) async {
    final db = await database;
    return await db.insert('notifications', notification.toMap());
  }

  Future<List<NotificationModel>> getNotifications() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notifications');
    return List.generate(maps.length, (index) {
      return NotificationModel.fromMap(maps[index]);
    });
  }

  Future<void> deleteNotification(int id) async {
    final db = await database;
    await db.delete('notifications', where: "id = ?", whereArgs: [id]);
  }
}
