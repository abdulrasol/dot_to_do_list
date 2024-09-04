import 'package:dot_to_do_list/models/task_model.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  RxList<TaskModel> toDolist = RxList.empty();
}
