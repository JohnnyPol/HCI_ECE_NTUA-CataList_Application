// databaseHelper.dart

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
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY, username TEXT UNIQUE, firstName TEXT, lastName TEXT, email TEXT, password TEXT)',
        );
        await db.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, user_id INTEGER, title TEXT, description TEXT, completed INTEGER, category TEXT, date TEXT, time TEXT, FOREIGN KEY (user_id) REFERENCES users (id))',
        );
        // Create indexes
        await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_title ON tasks (title)',
        );
        await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_description ON tasks (description)',
        );
        await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_category ON tasks (category)',
        );
        await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_date ON tasks (date)',
        );
        await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_user_id ON tasks (user_id)',
        );
      },
      version: 1,
      onUpgrade: (db, oldVersion, newVersion) async {
        // Add indexes in case of upgrades
        await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_title ON tasks (title)',
        );
        await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_description ON tasks (description)',
        );
        await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_category ON tasks (category)',
        );
        await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_date ON tasks (date)',
        );
        await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_user_id ON tasks (user_id)',
        );
      },
    );
  }

  /* User CRUD Operations*/

  // Get user by ID
  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Get ID by username
  Future<int?> getUserId(String username) async {
    final db = await database;
    final result = await db.query(
      'users',
      columns: ['id'],
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );
    return result.isNotEmpty ? result.first['id'] as int : null;
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

  // Check if user exists
  Future<List<Map<String, dynamic>>> getUserByUsername(String username) async {
    final db = await database;
    return db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
  }

  Future<void> deleteUser(int userId) async {
    final db = await database;
    await db.delete('tasks',
        where: 'user_id = ?', whereArgs: [userId]); // Deletes associated tasks
    await db
        .delete('users', where: 'id = ?', whereArgs: [userId]); // Deletes user
  }

  /* Task table CRUD Operations*/

  // Get all tasks for a user
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

  // Get tasks by date
  Future<List<Map<String, dynamic>>> getTasksForDate(
      int? userId, String date) async {
    final db = await database;
    return db.query(
      'tasks',
      where: 'user_id = ? AND date = ?',
      whereArgs: [userId, date],
    );
  }

  // Get tasks for weekly recap
  Future<List<Map<String, dynamic>>> getTasksForWeek(
      int? userId, int weekIndex) async {
    final db = await database;

    // Calculate the start and end dates for the week
    final now = DateTime.now();
    final startOfWeek =
        now.subtract(Duration(days: now.weekday - 1 + weekIndex * 7));
    final endOfWeek = startOfWeek.add(Duration(days: 6));

    final String startDate = startOfWeek.toIso8601String().split('T')[0];
    final String endDate = endOfWeek.toIso8601String().split('T')[0];

    // Fetch tasks within the week range
    return db.query(
      'tasks',
      where: 'user_id = ? AND date BETWEEN ? AND ?',
      whereArgs: [userId, startDate, endDate],
      orderBy: 'date ASC, time ASC',
    );
  }

  // Get tasks for monthly recap
  Future<List<Map<String, dynamic>>> getTasksForMonth(
      int? userId, int monthIndex) async {
    final db = await database;

    // Get the current date
    final now = DateTime.now();

    // Calculate the target month and year
    final DateTime targetMonth = DateTime(now.year, now.month - monthIndex, 1);

    // Calculate the start and end dates for the month
    final DateTime startOfMonth =
        DateTime(targetMonth.year, targetMonth.month, 1);
    final DateTime endOfMonth = DateTime(
        targetMonth.year, targetMonth.month + 1, 0); // Last day of the month

    final String startDate = startOfMonth.toIso8601String().split('T')[0];
    final String endDate = endOfMonth.toIso8601String().split('T')[0];

    // Fetch tasks within the month range
    return db.query(
      'tasks',
      where: 'user_id = ? AND date BETWEEN ? AND ?',
      whereArgs: [userId, startDate, endDate],
      orderBy: 'date ASC, time ASC',
    );
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

  // Update a task Completion
  Future<int> updateTaskCompletion(int taskId, int completed) async {
    final db = await database;
    return await db.update(
      'tasks',
      {'completed': completed},
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  /// Update a specific field of a task by ID (TEXT field)
  Future<int> updateTaskField(int taskId, String field, String newValue) async {
    final db = await database;

    return await db.update(
      'tasks',
      {field: newValue}, // Update the specified field with the new value
      where: 'id = ?', // Match the task by its ID
      whereArgs: [taskId],
    );
  }

  // Search tasks
  Future<List<Map<String, dynamic>>> searchTasks(
      String query, int? userId) async {
    final db = await database;
    return db.query('tasks',
        where:
            '(LOWER(title) LIKE LOWER(?) OR LOWER(description) LIKE LOWER(?))AND user_id = ?',
        whereArgs: ['%$query%', '%$query%', userId],
        orderBy: 'date ASC');
  }

  // Method to delete a task
  Future<int> deleteTask(int taskId) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  /* Database Handling*/
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
