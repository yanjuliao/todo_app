// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_import

import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/subtask_model.dart';
import 'package:todo_app/models/task_model.dart';

class SubtaskProvider extends ChangeNotifier {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<Subtask> _subtasks = [];
  List<Subtask> get subtasks => _subtasks;

  Future<List<Subtask>> loadSubtasks(int taskId) async {
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

    return _subtasks;
  }

  Future<List<Map<String, dynamic>>> getSubTasks(taskId) async {
    return await _databaseHelper.getSubtasks(taskId);
  }

  Future<List<Map<String, dynamic>>> getSubTaskById(int id) async {
    return await _databaseHelper.getSubtaskById(id);
  }

  Future<void> addSubtask(String title, int taskId) async {
    int subtaskId = _generateSubtaskId();
    _subtasks.clear();
    _subtasks = await loadSubtasks(taskId);

    Map<String, dynamic> subTask = {
      'id': subtaskId,
      'taskId': taskId,
      'title': title,
      'isCompleted': false,
    };

    await _databaseHelper.insertSubtask(subTask);
    notifyListeners();
  }

  Future<void> updateSubtaskStatus(
      Subtask updatedSubtask, bool isCompleted) async {
    _subtasks.clear();

    _subtasks = await loadSubtasks(updatedSubtask.taskId);

    Subtask existingSubtask =
        _subtasks.firstWhere((subtask) => subtask.id == updatedSubtask.id);

    existingSubtask.isCompleted = isCompleted;

    await _databaseHelper.updateSubtask(existingSubtask.toMap());

    notifyListeners();
  }

  Future<void> updateSubtask(Subtask updatedSubTask) async {
    _subtasks.clear();
    _subtasks = await loadSubtasks(updatedSubTask.taskId);

    await _databaseHelper.updateSubtask(updatedSubTask.toMap());
    notifyListeners();
  }

  Future<void> deleteSubtask(Subtask deletedSubtask) async {
    await _databaseHelper.deleteSubtask(deletedSubtask.id);
    _subtasks.removeAt(deletedSubtask.id);
    notifyListeners();
  }

  int _generateSubtaskId() {
    DateTime now = DateTime.now();
    int subtaskId = now.microsecondsSinceEpoch;
    return subtaskId;
  }
}
