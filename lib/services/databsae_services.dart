import 'package:appwrite/appwrite.dart';
import 'package:dot_to_do_list/models/task_model.dart';
import 'package:get_storage/get_storage.dart';

class DatabsaeServices {
  Client client = Client();
  GetStorage box = GetStorage();

  DatabsaeServices() {
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('66d40908001cfa0aae91')
        .setSelfSigned(status: true);
    box.listenKey('tasks', (value) {
     // print(value);
    });
  }

  void saveToDo(TaskModel todo) {
    List<Map> todoList = box.read('todo') ?? [];
    todoList.add(todo.toMap());
    box.write('tasks', todoList);
  }
}
