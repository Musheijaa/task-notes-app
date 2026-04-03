import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_notes_app_fixed/models/task_item.dart';
import 'package:task_notes_app_fixed/constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${AppConstants.tasksTable} (
        ${AppConstants.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${AppConstants.titleColumn} TEXT NOT NULL,
        ${AppConstants.priorityColumn} TEXT NOT NULL,
        ${AppConstants.descriptionColumn} TEXT,
        ${AppConstants.isCompletedColumn} INTEGER NOT NULL DEFAULT 0
      )
    ''');
    
    // Insert sample data
    await db.insert(AppConstants.tasksTable, {
      AppConstants.titleColumn: 'Complete Flutter assignment',
      AppConstants.priorityColumn: AppConstants.priorityHigh,
      AppConstants.descriptionColumn: 'Implement task manager app',
      AppConstants.isCompletedColumn: 0,
    });
    await db.insert(AppConstants.tasksTable, {
      AppConstants.titleColumn: 'Buy groceries',
      AppConstants.priorityColumn: AppConstants.priorityLow,
      AppConstants.descriptionColumn: 'Milk, bread, fruits',
      AppConstants.isCompletedColumn: 1,
    });
    await db.insert(AppConstants.tasksTable, {
      AppConstants.titleColumn: 'Plan weekend activities',
      AppConstants.priorityColumn: AppConstants.priorityMedium,
      AppConstants.descriptionColumn: 'Research local events',
      AppConstants.isCompletedColumn: 0,
    });
  }

  Future<int> insertTask(TaskItem task) async {
    final db = await database;
    final taskMap = task.toJson();
    taskMap.remove(AppConstants.idColumn); // Remove id to let SQLite auto-generate
    return await db.insert(AppConstants.tasksTable, taskMap);
  }

  Future<List<TaskItem>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.tasksTable,
      orderBy: '${AppConstants.idColumn} DESC',
    );
    return maps.map((map) => TaskItem.fromJson(map)).toList();
  }

  Future<int> updateTask(TaskItem task) async {
    final db = await database;
    return await db.update(
      AppConstants.tasksTable,
      task.toJson(),
      where: '${AppConstants.idColumn} = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      AppConstants.tasksTable,
      where: '${AppConstants.idColumn} = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}