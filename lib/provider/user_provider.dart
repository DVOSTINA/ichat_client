import 'package:flutter/material.dart';

import '../database/boxes.dart';
import '../database/users_db.dart';

class UserProvider with ChangeNotifier {
  Iterable<User> getAllUser({String? search = ''}) {
    return usersBox.values.where((element) {
      if (element.getFullName().contains(search!) || element.bio.contains(search) || element.username.contains(search)) {
        return true;
      }
      return false;
    });
  }

  User getUser(int userId) {
    return usersBox.values.firstWhere((element) => element.id == userId);
  }

  Future<void> setOnlineAt(int id, int onlineAt) async {
    for (var element in usersBox.values) {
      if (element.id == id) {
        element.onlineAt = onlineAt;
        await element.save();
      }
    }
    notifyListeners();
  }

  Future<void> clearUsers() async {
    await usersBox.clear();
    notifyListeners();
  }
}
