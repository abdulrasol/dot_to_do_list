import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UiController extends GetxController {
  // add to do due date var
  var dueDate = DateTime.now().obs;
  var format = DateFormat.yMd('ar');
}
