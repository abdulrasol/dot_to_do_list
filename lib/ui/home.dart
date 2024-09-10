import 'package:dot_to_do_list/controllers/ui_controller.dart';
import 'package:dot_to_do_list/ui/settings.dart';
import 'package:dot_to_do_list/ui/widgets/add_task_widget.dart';
import 'package:dot_to_do_list/ui/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/data_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.find();
    UiController uiController = Get.put(UiController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const Settings());
              },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(
          () => ListView(
            children: dataController.tasks
                .map((task) => TaskWidget(task: task))
                .toList(),
          ),
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
