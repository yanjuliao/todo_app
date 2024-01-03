import 'package:flutter/material.dart';
import 'package:todo_app/widgets/task_list.dart';
import 'package:todo_app/screens/add_task_screen.dart'; // Importe a classe AddTaskScreen corretamente

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}