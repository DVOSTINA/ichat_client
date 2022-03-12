import 'package:ichat/database/users_db.dart';

import '../database/boxes.dart';

User getMyInfo() {
  return configBox.get("MyInfo");
}

String getMyPassword() {
  return configBox.get("Password");
}

Future<void> setMyInfo({required User user, required String password}) async {
  await configBox.put("MyInfo", user);
  await configBox.put("Password", password);
}

Future<void> deleteInfo() async {
  await configBox.clear();
  await usersBox.clear();
  await roomsBox.clear();
  await messagesBox.clear();
}
