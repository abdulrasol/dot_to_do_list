import 'dart:convert';

import 'package:appwrite/models.dart';
import 'package:dot_to_do_list/models/task_model.dart';
import 'package:dot_to_do_list/services/database_services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:get_storage/get_storage.dart';

class DataController extends GetxController {
  Client client = Client();
  late AbstractDataBase databsaeServices;
  RxList<TaskModel> tasks = RxList.empty();
  late Rx<Account> account;
  late Rx<Session> session;
  late Rx<User> user;
  var logined = false.obs;
  final loginKey = 'login';
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
        updateLoginState(true);
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
      updateLoginState(false);

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
    if (loginState()) {
      databsaeServices = OnlineDataBase();
    } else {
      databsaeServices = LocalDataBase();
      print('local');
    }
    tasks.value = await databsaeServices.getTasks();
    box.listenKey('tasks', (temp) async {
      tasks.value = await databsaeServices.getTasks();
    });
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

  void initUser(User user) async {
    this.user = Rx<User>(user);
    updateLoginState(true);
  }

  bool loginState() {
    return box.read(loginKey) ?? false;
  }

  void updateLoginState(bool state) {
    logined.value = state;
    box.write(loginKey, state);
  }
}
