import 'package:dot_to_do_list/controllers/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import 'style.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.find();
    var btnController = RoundedLoadingButtonController();
    var email = TextEditingController();
    var password = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Email'),
              ),
              TextFormField(
                decoration: inputTextDecoration,
                controller: email,
                validator: (title) {
                  if (title!.isEmpty) {
                    return 'this record is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('password'),
              ),
              TextFormField(
                decoration: inputTextDecoration,
                controller: password,
                validator: (title) {
                  if (title!.isEmpty) {
                    return 'this record is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              RoundedLoadingButton(
                  color: Colors.deepPurple.shade500,
                  controller: btnController,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      var a = await dataController.login(
                          email: email.text, password: password.text);
                    } else {
                      btnController.stop();
                    }
                  },
                  child: const Text(
                    'login',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
