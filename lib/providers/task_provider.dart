// ignore_for_file: unused_element, prefer_const_constructors, prefer_final_fields

import 'package:flutter/foundation.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>> getTasks() async {
    return await _databaseHelper.getTasks();
  }

  Future<int> addTask(String title) async {
    int taskId = _generateId();

    Map<String, dynamic> task = {
      'id': taskId,
      'title': title,
      'isCompleted': 0,
    };

    await _databaseHelper.insertTask(task);
    notifyListeners();

    return taskId;
  }

  Future<void> updateTask(Task updatedTask) async {
    await _databaseHelper.updateTask(updatedTask.toMap());
    notifyListeners();
  }

  Future<void> updateTaskStatus(int taskId, bool isCompleted) async {
    Map<String, dynamic> task = {
      'id': taskId,
      'isCompleted': isCompleted ? 1 : 0,
    };
    await _databaseHelper.updateTask(task);
    notifyListeners();
  }

  Future<void> deleteTask(int taskId) async {
    await _databaseHelper.deleteTask(taskId);
    notifyListeners();
  }

  int _generateId() {
    DateTime now = DateTime.now();
    int taskId = now.microsecondsSinceEpoch;
    return taskId;
  }
}
