import 'package:dot_to_do_list/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  final TaskModel task;
  const TaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
    );
  }
}
