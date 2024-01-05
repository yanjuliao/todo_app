// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously, unused_field, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/subtask_provider.dart';

class AddSubtaskScreen extends StatefulWidget {
  final int taskId;

  AddSubtaskScreen({required this.taskId});

  @override
  _AddSubtaskScreenState createState() => _AddSubtaskScreenState();
}

class _AddSubtaskScreenState extends State<AddSubtaskScreen> {
  late int _taskId;
  final TextEditingController _subtaskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _taskId = widget.taskId;
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
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                SubtaskProvider subtaskProvider =
                    Provider.of<SubtaskProvider>(context, listen: false);

                if (_taskId != null) {
                  int subtaskId = await subtaskProvider.addSubtask(_taskId, _subtaskController.text);

                  Navigator.pop(context, subtaskId);
                } else {
                  // Handle the case when _taskId is null
                  print("Error: _taskId is null");
                }
              },
              child: Text('Adicionar Subtarefa'),
            ),
          ],
        ),
      ),
    );
  }
}