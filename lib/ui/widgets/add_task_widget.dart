import 'package:dot_to_do_list/services/ui_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTaskWidget extends StatelessWidget {
  // AddTaskWidget({super.key});

  const AddTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UiController uiController = Get.find();

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController titleText = TextEditingController();
    TextEditingController contenctText = TextEditingController();
    InputDecoration textDecoration = const InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 2, color: Colors.black54),
      ),
    );
    return //Scaffold(
        //  body:
        Padding(
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
            )
          ],
        ),
      ),
    );
  }
}
