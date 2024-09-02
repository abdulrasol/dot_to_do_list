import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTaskWidget extends StatelessWidget {
  // AddTaskWidget({super.key});

  const AddTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
            )
          ],
        ),
      ),
    );
  }
}
