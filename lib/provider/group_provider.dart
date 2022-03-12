import 'package:flutter/material.dart';

import '../database/boxes.dart';
import '../database/groups_db.dart';

class GroupProvider with ChangeNotifier {
  Iterable<Group> getAllGroup({String? search = ''}) {
    return groupsBox.values.where((element) {
      if (element.title.contains(search!) || element.description.contains(search)) {
        return true;
      }
      return false;
    });
  }

  Group getGroup(int groupId) {
    return groupsBox.values.singleWhere((element) => element.id == groupId);
  }

  // String getLastViewContains(Iterable<Contact> user, int index) {
  //   return user.elementAt(index).lastView;
  // }

  // void setLastView(String username, String lastView) {
  //   contacts.values.singleWhere((element) => element.userName == username).lastView = lastView;
  //   notifyListeners();
  // }
}
