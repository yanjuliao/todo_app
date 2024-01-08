// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/subtask_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/subtask_provider.dart';
import 'package:todo_app/screens/subtask/edit_subtask_screen.dart';

class SubtaskItem extends StatelessWidget {
  final Task task;
  final Subtask subtask;

  SubtaskItem({required this.task, required this.subtask});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(
          subtask.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Checkbox(
          value: subtask.isCompleted,
          onChanged: (value) {
            SubtaskProvider subtaskProvider =
                Provider.of<SubtaskProvider>(context, listen: false);
            subtaskProvider.updateSubtaskStatus(subtask, value!);
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EditSubtaskScreen(task: task, subtask: subtask),
            ),
          );
        },
        onLongPress: () {
          SubtaskProvider subtaskProvider =
              Provider.of<SubtaskProvider>(context, listen: false);
          subtaskProvider.deleteSubtask(subtask);
        },
      ),
    );
  }
}
