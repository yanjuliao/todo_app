// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously, unused_field, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/subtask_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/task/edit_task_screen.dart';
import 'package:todo_app/models/task_model.dart';

class AddSubtaskScreen extends StatefulWidget {
  final Task task;

  AddSubtaskScreen({required this.task});

  @override
  _AddSubtaskScreenState createState() => _AddSubtaskScreenState();
}

class _AddSubtaskScreenState extends State<AddSubtaskScreen> {
  late int _taskId;
  final TextEditingController _subtaskController = TextEditingController();
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _taskId = widget.task.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Subtarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _subtaskController,
              decoration: InputDecoration(
                labelText: 'Nova Subtarefa',
                errorText: _showError ? 'Por favor, preencha este campo' : null,
              ),
            ),
            SizedBox(height: 20),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _showError = _subtaskController.text.isEmpty;
                    });
                    if (_subtaskController.text.isNotEmpty) {
                      SubtaskProvider subtaskProvider =
                          Provider.of<SubtaskProvider>(context, listen: false);
                      await subtaskProvider.addSubtask(
                          _subtaskController.text, _taskId);
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditTaskScreen(task: widget.task),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Adicionar SubTarefa',
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
