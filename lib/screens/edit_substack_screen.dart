// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/subtask_model.dart';
import 'package:todo_app/providers/subtask_provider.dart';

class EditSubtaskScreen extends StatefulWidget {
  final Subtask subtask;

  EditSubtaskScreen({required this.subtask});

  @override
  _EditSubtaskScreenState createState() => _EditSubtaskScreenState();
}

class _EditSubtaskScreenState extends State<EditSubtaskScreen> {
  late TextEditingController _subtaskController;

  @override
  void initState() {
    super.initState();
    _subtaskController = TextEditingController(text: widget.subtask.title);
  }

  void _updateSubtaskAndNavigateBack(BuildContext context) async {
    SubtaskProvider subtaskProvider =
        Provider.of<SubtaskProvider>(context, listen: false);

    await subtaskProvider.updateSubtask(
      widget.subtask.id,
      _subtaskController.text,
    );

    Navigator.pop(context);
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
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _updateSubtaskAndNavigateBack(context),
              child: Text('Atualizar Subtarefa'),
            ),
          ],
        ),
      ),
    );
  }
}
