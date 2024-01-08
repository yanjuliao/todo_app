// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/subtask_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/subtask_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/task/edit_task_screen.dart';

class EditSubtaskScreen extends StatefulWidget {
  final Task task;
  final Subtask subtask;

  EditSubtaskScreen({required this.task, required this.subtask});

  @override
  _EditSubtaskScreenState createState() => _EditSubtaskScreenState();
}

class _EditSubtaskScreenState extends State<EditSubtaskScreen> {
  late TextEditingController _subtaskController;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _subtaskController = TextEditingController(text: widget.subtask.title);
  }

  void _updateSubtaskAndNavigateBack(BuildContext context) async {
    setState(() {
      _showError = _subtaskController.text.isEmpty;
    });
    if (_subtaskController.text.isNotEmpty) {
      SubtaskProvider subtaskProvider =
          Provider.of<SubtaskProvider>(context, listen: false);
      Subtask updatedSubtask =
          widget.subtask.copyWith(title: _subtaskController.text);
      await subtaskProvider.updateSubtask(updatedSubtask);
      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => EditTaskScreen(task: widget.task),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Subtarefa'),
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
                  onPressed: () => _updateSubtaskAndNavigateBack(context),
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
    );
  }
}
