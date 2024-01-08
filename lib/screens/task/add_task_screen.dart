// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, library_private_types_in_public_api, use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, use_build_context_synchronously, unused_field, unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/subtask_provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/subtask/add_subtask_screen.dart';
import 'package:todo_app/widgets/subtask/subtask_list.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _subtaskController = TextEditingController();
  late int _taskId;
  bool _showError = false;

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
                labelText: 'Título da Tarefa',
                errorText: _showError ? 'Por favor, preencha este campo' : null,
              ),
            ),
            SizedBox(height: 20),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _showError = _taskController.text.isEmpty;
                    });
                    if (_taskController.text.isNotEmpty) {
                      TaskProvider taskProvider =
                          Provider.of<TaskProvider>(context, listen: false);
                      await taskProvider.addTask(_taskController.text);

                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Adicionar Tarefa',
                    style: TextStyle(
                      color: themeProvider.elevatedButtonTextColor,
                    ),
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
