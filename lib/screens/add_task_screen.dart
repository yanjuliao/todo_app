// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, library_private_types_in_public_api, use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, use_build_context_synchronously, unused_field

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/subtask_provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/add_subtask_screen.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _subtaskController = TextEditingController();
  late int _taskId;  

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
              ),
            ),
            SizedBox(height: 20),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return ElevatedButton(
                  onPressed: () async {
                    TaskProvider taskProvider =
                        Provider.of<TaskProvider>(context, listen: false);
                    _taskId = await taskProvider.addTask(_taskController.text);  
                    Navigator.pop(context);
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
            SizedBox(height: 20),
            Consumer<SubtaskProvider>(
              builder: (context, subtaskProvider, child) {
                return Column(
                  children: [
                    Text(
                      'Subtasks',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 150,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: subtaskProvider.subtasks.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(subtaskProvider.subtasks[index].title),
                            trailing: Checkbox(
                              value: subtaskProvider.subtasks[index].isCompleted,
                              onChanged: (value) {
                                subtaskProvider.updateSubtaskStatus(
                                  subtaskProvider.subtasks[index].id,
                                  value ?? false,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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