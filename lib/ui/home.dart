import 'package:dot_to_do_list/models/task_model.dart';
import 'package:dot_to_do_list/ui/widgets/add_task_widget.dart';
import 'package:dot_to_do_list/ui/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            TaskWidget(
              task: TaskModel(
                id: 'id',
                title: 'Task 01',
                dueDate: DateTime(2024, 9, 2),
                createdAt: DateTime(2024, 1, 1),
                hasReminder: true,
              ),
            ),
            TaskWidget(
              task: TaskModel(
                id: 'id',
                title: 'c b منسق',
                description: 'يسقط -, أسبرناتور نفسه مبروك.',
                dueDate: DateTime.now(),
                createdAt: DateTime(2024, 1, 1),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.defaultDialog(
            barrierDismissible: false,
            title: 'New Task',
            titlePadding: const EdgeInsets.all(8),
            contentPadding: const EdgeInsets.all(8),
            content: const AddTaskWidget(),
            //textCancel: 'Cancel',
            //textConfirm: 'Save',
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
