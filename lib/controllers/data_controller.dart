import 'package:appwrite/models.dart';
import 'package:dot_to_do_list/models/task_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataController extends GetxController {
  Client client = Client();
  RxList<TaskModel> toDolist = RxList.empty();
  late Rx<Account> account;
  late Rx<Session> session;
  late Rx<User> user;
  late SharedPreferences sharedInstance;
  var loginState = false.obs;
  // auth
  Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    try {
      session = Rx<Session>(await account.value
          .createEmailPasswordSession(email: email, password: password));
      if (session.value.current) {
        sharedInstance.setBool('login', true);
        sharedInstance.setString(
          'session',
          session.value.$id,
        );
        user = Rx<User>(await account.value.get());
        loginState.value = true;
      }
      return {
        'state': true,
      };
    } catch (e) {
      print(e.toString().split(', ')[1]);

      return {'state': false, 'msg': e.toString().split(', ')[1]};
    }
  }

  Future<bool> logout() async {
    try {
      await account.value.deleteSessions();
      sharedInstance.remove('login');
      sharedInstance.remove('session');
      loginState.value = false;
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  // update user config
  Future<void> updateUserConfig() async {}

  @override
  void onInit() async {
    sharedInstance = await SharedPreferences.getInstance();
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('66d40908001cfa0aae91')
        .setSelfSigned(status: true);
    account = Rx<Account>(Account(client));

    super.onInit();
  }
}
