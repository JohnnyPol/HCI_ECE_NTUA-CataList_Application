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
          'CREATE TABLE users (id INTEGER PRIMARY KEY, username TEXT UNIQUE, firstName TEXT, lastName TEXT, email TEXT, password TEXT)',
        );
        db.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, user_id INTEGER, title TEXT, description TEXT, completed INTEGER, category TEXT, date TEXT, time TEXT, FOREIGN KEY (user_id) REFERENCES users (id))',
        );
      },
      version: 1,
    );
  }

  // Add a new user to the database
  Future<int> addUser(String username, String firstName, String lastName,
      String email, String password) async {
    final db = await database;
    try {
      return await db.insert('users', {
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      });
    } catch (e) {
      // Handle unique constraint error or other issues
      return -1; // Indicate failure
    }
  }

  // Authenticate a user
  Future<List<Map<String, dynamic>>> authUser(
      String username, String password) async {
    final db = await database;
    return db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
  }

  // Get tasks for a user
  Future<List<Map<String, dynamic>>> getTasks(int? userId) async {
    final db = await database;
    return db.query('tasks', where: 'user_id = ?', whereArgs: [userId]);
  }

  // Get tasks for a user by category
  Future<List<Map<String, dynamic>>> getTasksByCategory(
      int? userId, String category) async {
    final db = await database;
    return db.query('tasks',
        where: 'user_id = ? AND category = ?', whereArgs: [userId, category]);
  }

  // Add a new task
  Future<int> addTask(int? userId, String title, String description,
      int completed, String category, String date, String time) async {
    final db = await database;
    return db.insert('tasks', {
      'user_id': userId,
      'title': title,
      'description': description,
      'completed': completed,
      'category': category,
      'date': date,
      'time': time,
    });
  }

  // Add this method to delete all tables
  Future<void> deleteAllTables() async {
    final db = await database;

    // Fetch all table names
    final List<Map<String, dynamic>> tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';");

    // Drop each table
    for (var table in tables) {
      String tableName = table['name'];
      await db.execute("DROP TABLE IF EXISTS $tableName");
    }
  }
}
