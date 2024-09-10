import 'package:dot_to_do_list/controllers/data_controller.dart';
import 'package:dot_to_do_list/models/task_model.dart';
import 'package:dot_to_do_list/controllers/ui_controller.dart';
import 'package:dot_to_do_list/services/databsae_services.dart';
import 'package:dot_to_do_list/ui/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTaskWidget extends StatelessWidget {
  // AddTaskWidget({super.key});

  const AddTaskWidget({super.key});
  @override
  Widget build(BuildContext context) {
    UiController uiController = Get.find();
    DataController dataController = Get.find();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController titleText = TextEditingController();
    TextEditingController contenctText = TextEditingController();

    Priority priority = Priority.medium;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: inputTextDecoration.copyWith(
                label: const Text('Task Title'),
              ),
              controller: titleText,
              focusNode: FocusNode(),
              style: GoogleFonts.cairo(color: Colors.black),
              cursorColor: Colors.black,
              maxLength: 75,
              validator: (title) {
                if (title!.isEmpty) {
                  return 'this record is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: inputTextDecoration.copyWith(
                label: const Text('Task Description'),
              ),
              controller: contenctText,
              focusNode: FocusNode(),
              style: GoogleFonts.cairo(color: Colors.black),
              cursorColor: Colors.black,
              maxLines: 5,
              maxLength: 300,
            ),

            // due date
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  firstDate: uiController.dueDate.value
                      .subtract(const Duration(days: 30)),
                  currentDate: uiController.dueDate.value,
                  lastDate: uiController.dueDate.value.add(
                    const Duration(days: 365),
                  ),
                );
                if (picked != null && picked != uiController.dueDate.value) {
                  uiController.dueDate.value = picked;
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Select Due Date'),
                    Obx(() => Text(
                          uiController.dateFormat
                              .format(uiController.dueDate.value),
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Priority
            Row(
              children: [
                const Text('Priority'),
                const Expanded(child: SizedBox()),
                DropdownMenu(
                    initialSelection: priority,
                    onSelected: ((selected) {
                      priority = selected!;
                    }),
                    dropdownMenuEntries: Priority.values.map((i) {
                      return DropdownMenuEntry(
                          value: i,
                          label: i.toString().split('.')[1].capitalizeFirst!);
                    }).toList()),
              ],
            ),

            // حقل التذكير (Reminder Switch)
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Reminder'),
                Obx(() => Switch(
                      value: uiController.hasReminder.value,
                      onChanged: (value) {
                        uiController.hasReminder.value = value;
                      },
                    )),
              ],
            ),
            const SizedBox(height: 10),
            Obx(
              () {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: uiController.hasReminder.value ? 60.0 : 0.0,
                  curve: Curves.easeInOut,
                  child: uiController.hasReminder.value
                      ? GestureDetector(
                          onTap: () async {
                            TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: uiController.reminderTime.value);

                            if (picked != null &&
                                picked != uiController.reminderTime.value) {
                              uiController.reminderTime.value = picked;
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Reminder Time ${uiController.reminderTime.value.format(context)}',
                                ),
                                const Icon(Icons.access_time),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                );
              },
            ),
            const SizedBox(height: 10),
            // confirm or cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      print(dataController.tasks);
                      Get.back();
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        var task = TaskModel(
                            id: '1',
                            title: titleText.text,
                            description: contenctText.text,
                            dueDate: uiController.dueDate.value,
                            priority: priority,
                            createdAt: DateTime.now(),
                            hasReminder: uiController.hasReminder.value);
                        dataController.saveTask(task);
                        Get.back();
                      }
                    },
                    child: const Text('Save')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
