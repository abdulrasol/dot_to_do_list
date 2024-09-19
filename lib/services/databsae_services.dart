import 'package:appwrite/appwrite.dart';
import 'package:dot_to_do_list/models/task_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class DatabsaeServices {
  Client client = Client();
  GetStorage box = GetStorage();
  late Databases databases;
  final String databaseID = '66d40ec5001fd6f45d88';
  final String taskID = '66d40ec5001fd6f45d88-tasks';

  DatabsaeServices() {
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('66d40908001cfa0aae91')
        .setSelfSigned(status: true);
    databases = Databases(client);
  }

  void saveToDo(TaskModel todo) {
    List<Map> todoList = box.read('todo') ?? [];
    todoList.add(todo.toMap());
    box.write('tasks', todoList);
  }

  Future addTask(TaskModel task) async {
    try {
      String id = ID.unique();
      task.id = id;

      await databases.createDocument(
          databaseId: databaseID,
          collectionId: taskID,
          documentId: id,
          data: task.toMap());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<List<TaskModel>> getTasks() async {
    databases
        .listDocuments(databaseId: databaseID, collectionId: taskID)
        .asStream();
    return await databases
        .listDocuments(databaseId: databaseID, collectionId: taskID)
        .then(
          (tasks) => tasks.documents.map((task) {
            return TaskModel.fromMap(task.data);
          }).toList(),
        );
  }
}
