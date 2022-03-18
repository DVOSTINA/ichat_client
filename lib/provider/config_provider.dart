import 'package:flutter/material.dart';
import 'package:ichat/server/server_api.dart';
import 'package:ichat/server/server_socket.dart';

import '../data/info.dart';
import '../database/boxes.dart';
import '../database/users_db.dart';

class ConfigProvider with ChangeNotifier {
  bool getDarkTheme() {
    return configBox.get("Theme", defaultValue: false);
  }

  void setTheme() {
    configBox.put("Theme", !getDarkTheme());
    notifyListeners();
  }

  Future<void> setLastNotify(int lastTime) async {
    await serverApi.lastNotify(lastTime);

    User user = getMyInfo();
    user.lastNotify = lastTime;
    await setMyInfo(user: user, password: getMyPassword());

    notifyListeners();
  }

  bool getSocketStatus() {
    return socketManager.socket.connected;
  }

  void setSocketStatus() {
    notifyListeners();
  }
}
