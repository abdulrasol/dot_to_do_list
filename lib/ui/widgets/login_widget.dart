import 'package:dot_to_do_list/controllers/data_controller.dart';
import 'package:dot_to_do_list/controllers/ui_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'style.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.find();
    UiController uiController = Get.put(UiController());
    var btnController = RoundedLoadingButtonController();
    var email = TextEditingController();
    var password = TextEditingController();
    var comfirmPassword = TextEditingController();
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
              TextFormField(
                decoration: inputTextDecoration.copyWith(
                  prefixIcon: const Icon(Icons.email),
                  label: const Text('Email'),
                ),
                controller: email,
                validator: (title) {
                  if (title!.isEmpty) {
                    return 'this record is required';
                  }
                  if (!GetUtils.isEmail(title)) {
                    return 'invalid email fromat';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Obx(
                () => TextFormField(
                  decoration: inputTextDecoration.copyWith(
                      label: const Text('Password'),
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                          onPressed: () {
                            uiController.passwordVisiblty.toggle();
                          },
                          icon: Icon(uiController.passwordVisiblty.value
                              ? Icons.visibility_off
                              : Icons.visibility))),
                  controller: password,
                  obscureText: !uiController.passwordVisiblty.value,
                  validator: (title) {
                    if (title!.isEmpty) {
                      return 'this record is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15),
              Obx(
                () => uiController.haveAccount.value
                    ? const SizedBox.shrink()
                    : TextFormField(
                        decoration: inputTextDecoration.copyWith(
                          label: const Text('Comfirm Password'),
                          prefixIcon: const Icon(Icons.password),
                        ),
                        controller: comfirmPassword,
                        obscureText: !uiController.passwordVisiblty.value,
                        validator: (title) {
                          if (title!.isEmpty) {
                            return 'this record is required';
                          }
                          if (comfirmPassword.text != password.text) {
                            return 'Password doesn\'t match';
                          }
                          return null;
                        },
                      ),
              ),
              const SizedBox(height: 15),
              RoundedLoadingButton(
                color: Colors.deepPurple.shade500,
                controller: btnController,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    var login = await dataController.login(
                        email: email.text, password: password.text);
                    if (login['state']) {
                      btnController.success();
                      await Future.delayed(const Duration(milliseconds: 3));
                      Get.back();
                    } else {
                      uiController.loginMsg.value = login['msg'];
                      uiController.loginState.value = login['state'];
                      btnController.error();
                    }
                  } else {
                    btnController.stop();
                  }
                },
                child: Obx(
                  () => Text(
                    uiController.haveAccount.value ? 'Login' : 'Register',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              uiController.loginState.value
                  ? const SizedBox.shrink()
                  : Text(uiController.loginMsg.value),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      uiController.haveAccount.toggle();
                    },
                    child: Obx(() => Text(
                        uiController.haveAccount.value ? 'Register' : 'Login')),
                  ),
                  Obx(
                    () => !uiController.haveAccount.value
                        ? const SizedBox.shrink()
                        : TextButton(
                            onPressed: () {},
                            child: const Text('Forget Password'),
                          ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
