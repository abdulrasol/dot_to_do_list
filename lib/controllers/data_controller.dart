import 'package:appwrite/models.dart';
import 'package:dot_to_do_list/models/task_model.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';

class DataController extends GetxController {
  Client client = Client();
  RxList<TaskModel> toDolist = RxList.empty();
  late Rx<Account> user;
  late Rx<Session> session;

  // auth
  Future<bool> login({required String email, required String password}) async {
    try {
      var s = await user.value
          .createEmailPasswordSession(email: email, password: password);
      print(s.current);
    } catch (e) {
      print(e);
    }
    return true;
  }

  @override
  void onInit() {
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('66d40908001cfa0aae91')
        .setSelfSigned(status: true);
    user = Rx<Account>(Account(client));
//session = Account(client)
    //print(user.value.);
    //print(session);
    super.onInit();
  }
}
