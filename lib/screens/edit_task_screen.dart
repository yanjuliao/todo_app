// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/add_subtask_screen.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  EditTaskScreen({required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _taskController;
  late int _taskId;  

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController(text: widget.task.title);
  }

  void _updateTaskAndNavigateBack(BuildContext context) {
    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);
    Task updatedTask = widget.task.copyWith(title: _taskController.text);
    taskProvider.updateTask(updatedTask);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Titulo da Tarefa',
              ),
            ),
            SizedBox(height: 20),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return ElevatedButton(
                  onPressed: () => _updateTaskAndNavigateBack(context),
                  child: Text(
                    'Atualizar Tarefa',
                    style:
                        TextStyle(color: themeProvider.elevatedButtonTextColor),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSubtaskScreen(taskId: _taskId),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
