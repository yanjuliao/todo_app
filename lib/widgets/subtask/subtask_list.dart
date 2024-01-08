// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/subtask_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/subtask_provider.dart';
import 'package:todo_app/widgets/subtask/subtask_item.dart';

class SubtaskList extends StatelessWidget {
  final Task task;

  SubtaskList({required this.task});

  @override
  Widget build(BuildContext context) {
    return Consumer<SubtaskProvider>(
      builder: (context, subtaskProvider, child) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: subtaskProvider.getSubTasks(task.id),
          builder: (context, snapshot) {
            List<Map<String, dynamic>> subtasks = snapshot.data!;
            if (subtasks.isEmpty) {
              return Center(
                child: Text("Nenhuma subtarefa cadastrada."),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: subtasks.length,
                  itemBuilder: (context, index) {
                    Subtask subtask = Subtask(
                      id: subtasks[index]['id'],
                      taskId: subtasks[index]['taskId'],
                      title: subtasks[index]['title'],
                      isCompleted: subtasks[index]['isCompleted'] == 1,
                    );

                    return Dismissible(
                      key: Key(subtask.id.toString()),
                      onDismissed: (direction) {
                        subtaskProvider.deleteSubtask(subtask);
                      },
                      background: Container(
                        color: Colors.red,
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: SubtaskItem(task: task, subtask: subtask),
                    );
                  },
                ),
              );
            }
          },
        );
      },
    );
  }
}
