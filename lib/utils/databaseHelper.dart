import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'app_database.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE users (id INTEGER PRIMARY KEY, username TEXT, firstName TEXT, lastName TEXT, email TEXT, password TEXT)');
        db.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, user_id INTEGER, title TEXT, completed INTEGER, category TEXT, date TEXT, time TEXT, FOREIGN KEY (user_id) REFERENCES users (id))');
      },
      version: 1,
    );
  }

  // Example CRUD operations
  Future<int> addUser(String username, String password) async {
    final db = await database;
    return db.insert('users', {'username': username, 'password': password});
  }

  Future<List<Map<String, dynamic>>> authUser(
      String username, String password) async {
    final db = await database;
    return db.query('users',
        where: 'username = ? && password= ?', whereArgs: [username, password]);
  }

  Future<List<Map<String, dynamic>>> getTasks(int userId) async {
    final db = await database;
    return db.query('tasks', where: 'user_id = ?', whereArgs: [userId]);
  }
}
