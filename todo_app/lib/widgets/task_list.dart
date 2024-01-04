// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/widgets/task_item.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: taskProvider.getTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              List<Map<String, dynamic>> tasks = snapshot.data!;
              return ListView.builder(               
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  Task task = Task(
                    id: tasks[index]['id'],
                    title: tasks[index]['title'],
                    isCompleted: tasks[index]['isCompleted'] == 1,
                  );

                  return Dismissible(
                    key: Key(task.id.toString()),
                    onDismissed: (direction) {
                      taskProvider.deleteTask(task.id);
                    },
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: TaskItem(task: task),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}