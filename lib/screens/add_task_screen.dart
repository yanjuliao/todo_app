// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Tarefa'),
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
                  onPressed: () {
                    TaskProvider taskProvider =
                        Provider.of<TaskProvider>(context, listen: false);
                    taskProvider.addTask(_taskController.text);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Adicionar Tarefa',
                    style:
                        TextStyle(color: themeProvider.elevatedButtonTextColor),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
