// ignore_for_file: unused_import

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/subtask_model.dart';

class DatabaseHelper {
  static const String _databaseName = 'todo.db';
  static const int _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY,
        title TEXT,
        isCompleted INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE subtasks (
        id INTEGER PRIMARY KEY,
        taskId INTEGER,
        title TEXT,
        isCompleted INTEGER
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    Database db = await instance.database;
    return await db.query('tasks');
  }

  Future<void> insertTask(Map<String, dynamic> task) async {
    Database db = await instance.database;
    await db.insert('tasks', task);
  }

  Future<void> updateTask(Map<String, dynamic> task) async {
    Database db = await instance.database;
    await db.update('tasks', task, where: 'id = ?', whereArgs: [task['id']]);
  }

  Future<void> deleteTask(int taskId) async {
    Database db = await instance.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
  }

  Future<List<Map<String, dynamic>>> getSubtasks(int taskId) async {
    Database db = await instance.database;
    return await db.query('subtasks', where: 'taskId = ?', whereArgs: [taskId]);
  }

    Future<List<Map<String, dynamic>>> getSubtaskById(int id) async {
    Database db = await instance.database;
    return await db.query('subtasks', where: 'Id = ?', whereArgs: [id]);
  }

  Future<void> insertSubtask(Map<String, dynamic> subtask) async {
    Database db = await instance.database;
    await db.insert('subtasks', subtask);
  }

  Future<void> updateSubtask(Map<String, dynamic> subtask) async {
    Database db = await instance.database;
    await db.update('subtasks', subtask, where: 'id = ?', whereArgs: [subtask['id']]);
  }

  Future<void> deleteSubtask(int subtaskId) async {
    Database db = await instance.database;
    await db.delete('subtasks', where: 'id = ?', whereArgs: [subtaskId]);
  }
}
