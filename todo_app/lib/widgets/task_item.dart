import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showEditTaskDialog(context);
            },
          ),
          Checkbox(
            value: task.isCompleted,
            onChanged: (value) {
              TaskProvider taskProvider =
                  Provider.of<TaskProvider>(context, listen: false);
              taskProvider.updateTaskStatus(task.id, value!);
            },
          ),
        ],
      ),
      onLongPress: () {
        TaskProvider taskProvider =
            Provider.of<TaskProvider>(context, listen: false);
        taskProvider.deleteTask(task.id);
      },
    );
  }

  void _showEditTaskDialog(BuildContext context) {
    TextEditingController _taskController =
        TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(
              labelText: 'Task Title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                TaskProvider taskProvider =
                    Provider.of<TaskProvider>(context, listen: false);
                Task updatedTask =
                    task.copyWith(title: _taskController.text);
                taskProvider.updateTask(updatedTask); // Corrigir o nome do método aqui
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}