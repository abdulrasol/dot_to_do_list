import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // لتخزين الإعدادات محلياً

class SettingsController extends GetxController {
  var notificationToggle = true.obs;
  Rx<TimeOfDay> defaultReminderTime = TimeOfDay.now().obs;
  RxString selectedTheme = 'Light'.obs;
  RxString selectedLanguage = 'en'.obs;

  var isDarkMode = false.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = box.read('darkmode') ?? false;
    selectedLanguage.value = box.read('lang') ?? 'en';
  }

  // change userTheme
  void toggleTheme(bool isDark) {
    isDarkMode.value = isDark;
    box.write('darkmode', isDark);
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void changeUserLangauge(String languageCode) {
    selectedLanguage.value = languageCode;
    box.write('lang', languageCode);
    Get.updateLocale(Locale(languageCode));
  }

  void toggleNotification(bool enable) {
    notificationToggle.value = enable;
    box.write('notification', enable);
  }
}
