import 'package:dot_to_do_list/models/task_model.dart';
import 'package:dot_to_do_list/ui/widgets/add_task_widget.dart';
import 'package:flutter/material.dart';

class AddEditTaskPage extends StatelessWidget {
  final TaskModel task;
  const AddEditTaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(onPressed: () {}, child: const Text('save')),
          )
        ],
      ),
      body: const AddTaskWidget(),
    );
  }
}
