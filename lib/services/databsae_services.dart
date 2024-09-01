import 'package:appwrite/appwrite.dart';

class DatabsaeServices {
  Client client = Client();

  DatabsaeServices() {
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('66d40908001cfa0aae91')
        .setSelfSigned(status: true);
  }

}
