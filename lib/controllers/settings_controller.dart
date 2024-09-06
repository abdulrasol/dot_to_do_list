import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var notificationToggle = true.obs;
  Rx<TimeOfDay> defaultReminderTime = TimeOfDay.now().obs;
  RxString selectedTheme = 'Light'.obs;
  RxString selectedLanguage = 'English'.obs;
}
