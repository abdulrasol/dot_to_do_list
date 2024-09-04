import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UiController extends GetxController {
  // date fromatter globally

  var dateFormat = DateFormat.yMd('ar');
  var timeFormat = DateFormat('Hms', 'ar');

  // add to do list widgets vars
  // add to do due date var
  var dueDate = DateTime.now().obs;
  var reminderTime = TimeOfDay.now().obs;
  var hasReminder = false.obs;
}
