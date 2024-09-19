import 'dart:convert';

import 'package:appwrite/models.dart';
import 'package:dot_to_do_list/models/task_model.dart';
import 'package:dot_to_do_list/services/databsae_services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:get_storage/get_storage.dart';

class DataController extends GetxController {
  Client client = Client();
  DatabsaeServices databsaeServices = DatabsaeServices();
  RxList<TaskModel> tasks = RxList.empty();
  late Rx<Account> account;
  late Rx<Session> session;
  late Rx<User> user;
  var loginState = false.obs;
  var box = GetStorage();

  // auth
  Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    try {
      session = Rx<Session>(await account.value
          .createEmailPasswordSession(email: email, password: password));
      if (session.value.current) {
        box.write('session', session.value.$id);
        user = Rx<User>(await account.value.get());
        loginState.value = true;
      }
      return {
        'state': true,
      };
    } catch (e) {
      return {'state': false, 'msg': e.toString().split(', ')[1]};
    }
  }

  Future<bool> logout() async {
    try {
      await account.value.deleteSession(sessionId: box.read('session'));
      box.remove('session');
      loginState.value = false;
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  @override
  void onInit() async {
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('66d40908001cfa0aae91')
        .setSelfSigned(status: true);
    account = Rx<Account>(Account(client));
    if (await box.read('session') != null) {
      tasks.value = await databsaeServices.getTasks();
    } else {
      box.listenKey('tasks', (todoList) {
        List tempList = box.read('tasks') ?? [];
        List<TaskModel> temList1 = tempList.map((i) {
          return TaskModel.fromMap(jsonDecode(i));
        }).toList();
        tasks.value = temList1;
      });
      List tempList = box.read('tasks') ?? [];
      List<TaskModel> temList1 = tempList.map((i) {
        return TaskModel.fromMap(jsonDecode(i));
      }).toList();
      tasks.value = temList1;
    }
    super.onInit();
  }

  void saveTask(TaskModel todo) {
    List tempTasks = box.read('tasks') ?? [];
    tempTasks.add(jsonEncode(todo.toMap()));
    box.write('tasks', tempTasks);
  }

  void compeletetask(TaskModel task) {
    TaskModel tempTask = tasks.firstWhere((item) => task == item);
    tempTask.isCompleted = !tempTask.isCompleted;
    var index = tasks.indexOf(task);
    tasks[index] = task;
    box.remove('tasks');
    box.write('tasks', tasks.map((i) => jsonEncode(i.toMap())));
  }

  void initUser() async {
    user = Rx<User>(await account.value.get());
  }
}
