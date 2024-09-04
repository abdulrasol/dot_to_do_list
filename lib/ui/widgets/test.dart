import 'package:dot_to_do_list/services/ui_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/task_model.dart';

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UiController uiController = Get.put(UiController());

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController titleText = TextEditingController();
    TextEditingController contenctText = TextEditingController();
    InputDecoration textDecoration = const InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 2, color: Colors.black54),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
                decoration: textDecoration.copyWith(
                  label: const Text('Task Title'),
                ),
                controller: titleText,
                focusNode: FocusNode(),
                style: GoogleFonts.cairo(color: Colors.black),
                cursorColor: Colors.black,
                maxLength: 75),
            const SizedBox(height: 10),
            TextFormField(
              decoration: textDecoration.copyWith(
                label: const Text('Task Description'),
              ),
              controller: contenctText,
              focusNode: FocusNode(),
              style: GoogleFonts.cairo(color: Colors.black),
              cursorColor: Colors.black,
              maxLines: 5,
              maxLength: 300,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Priority'),
                const Expanded(child: SizedBox()),
                DropdownMenu(
                    dropdownMenuEntries: Priority.values.map((i) {
                  return DropdownMenuEntry(
                      value: i,
                      label: i.toString().split('.')[1].capitalizeFirst!);
                }).toList()),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Select Due Date'),
                const Expanded(child: SizedBox()),
                Obx(
                  () => ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        firstDate: uiController.dueDate.value
                            .subtract(const Duration(days: 30)),
                        currentDate: uiController.dueDate.value,
                        lastDate: uiController.dueDate.value.add(
                          const Duration(days: 365),
                        ),
                      );
                      if (picked != null &&
                          picked != uiController.dueDate.value) {
                        uiController.dueDate.value = picked;
                      }
                    },
                    child: Text(
                      uiController.format.format(uiController.dueDate.value),
                    ),
                  ),
                ),
              ],
            ),

            // حقل التذكير (Reminder Switch)
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('تفعيل التذكير'),
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
                                  'وقت التذكير: ${uiController.reminderTime.value.format(context)}',
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
          ],
        ),
      ),
    );
  }
}
