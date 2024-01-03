import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/screens/edit_task_screen.dart'; 

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          TaskProvider taskProvider =
              Provider.of<TaskProvider>(context, listen: false);
          taskProvider.updateTaskStatus(task.id, value!);
        },
      ),
      onTap: () {
        _navigateToEditTaskScreen(context);
      },
      onLongPress: () {
        TaskProvider taskProvider =
            Provider.of<TaskProvider>(context, listen: false);
        taskProvider.deleteTask(task.id);
      },
    );
  }

  void _navigateToEditTaskScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(task: task),
      ),
    );
  }
}