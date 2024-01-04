import 'package:flutter/foundation.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>> getTasks() async {
    return await _databaseHelper.getTasks();
  }

  Future<void> addTask(String title) async {
    Map<String, dynamic> task = {
      'title': title,
      'isCompleted': 0,
    };
    await _databaseHelper.insertTask(task);
    notifyListeners();
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
}
