// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_import

import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/subtask_model.dart';

class SubtaskProvider extends ChangeNotifier {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<Subtask> _subtasks = [];
  List<Subtask> get subtasks => _subtasks;
  int _currentTaskId = 0;

  Future<void> loadSubtasks(int taskId) async {
    _currentTaskId = taskId;

    List<Map<String, dynamic>> subtasksData =
        await _databaseHelper.getSubtasks(taskId);

    _subtasks = subtasksData.map((subtaskData) {
      return Subtask(
        id: subtaskData['id'],
        taskId: taskId,
        title: subtaskData['title'],
        isCompleted: subtaskData['isCompleted'] == 1,
      );
    }).toList();

    notifyListeners();
  }

  Future<int> addSubtask(int taskId, String title) async {
  int subtaskId = _generateSubtaskId();

  Subtask subtask = Subtask(
    id: subtaskId,
    taskId: taskId,
    title: title,
    isCompleted: false,
  );

  await _databaseHelper.insertSubtask(subtask.toMap());
  _subtasks.add(subtask);
  notifyListeners();

  return subtaskId;
}

  Future<void> updateSubtaskStatus(int subtaskId, bool isCompleted) async {
    Subtask subtask =
        _subtasks.firstWhere((subtask) => subtask.id == subtaskId);
    subtask.isCompleted = isCompleted;

    await _databaseHelper.updateSubtask(subtask.toMap());
    notifyListeners();
  }

  Future<void> updateSubtask(int subtaskId, String title) async {
  Subtask subtask =
      _subtasks.firstWhere((subtask) => subtask.id == subtaskId);

  Subtask updatedSubtask = Subtask(
    id: subtask.id,
    taskId: subtask.taskId,
    title: title,
    isCompleted: subtask.isCompleted,
  );

  int subtaskIndex = _subtasks.indexWhere((subtask) => subtask.id == subtaskId);
  _subtasks[subtaskIndex] = updatedSubtask;

  await _databaseHelper.updateSubtask(updatedSubtask.toMap());
  notifyListeners();
}

  Future<void> deleteSubtask(int subtaskId) async {
    await _databaseHelper.deleteSubtask(subtaskId);
    _subtasks.removeWhere((subtask) => subtask.id == subtaskId);
    notifyListeners();
  }

  int _generateSubtaskId() {
    DateTime now = DateTime.now();
    int taskId = now.microsecondsSinceEpoch;
    return taskId;
  }

  int getCurrentTaskId() {
    return _currentTaskId;
  }
}
