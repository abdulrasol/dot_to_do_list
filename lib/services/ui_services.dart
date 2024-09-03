import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UiController extends GetxController {
  // date fromatter globally
  var format = DateFormat.yMd('ar');

  // add to do list widgets vars
  // add to do due date var
  var dueDate = DateTime.now().obs;
  Rx<DateTime>? reminderTime = DateTime.now().obs;
  var hasReminder = false.obs;
}
