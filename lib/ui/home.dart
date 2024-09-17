import 'package:dot_to_do_list/ui/settings.dart';
import 'package:dot_to_do_list/ui/widgets/add_task_widget.dart';
import 'package:dot_to_do_list/ui/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../controllers/data_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const Settings());
              },
              icon: const Icon(Icons.settings)),
          IconButton(
              onPressed: () {
                dataController.box.remove('tasks');
              },
              icon: const Icon(Icons.clear_all)),
          IconButton(
              onPressed: () async {
                const LinuxInitializationSettings linuxInitializationSettings =
                    LinuxInitializationSettings(
                  defaultActionName: 'test',
                );
                const InitializationSettings initializationSettings =
                    InitializationSettings(
                  linux: linuxInitializationSettings,
                );
                final FlutterLocalNotificationsPlugin
                    flutterLocalNotificationsPlugin =
                    FlutterLocalNotificationsPlugin();
                flutterLocalNotificationsPlugin
                    .initialize(initializationSettings);

                flutterLocalNotificationsPlugin.show(
                    1, 'title', DateTime.now().toLocal().toString(), null);
              },
              icon: const Icon(Icons.notifications_active)),
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
