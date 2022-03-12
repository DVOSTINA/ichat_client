import 'package:flutter/material.dart';
import 'package:ichat/server/server_socket.dart';

import '../database/boxes.dart';

class ConfigProvider with ChangeNotifier {
  bool getDarkTheme() {
    return configBox.get("Theme", defaultValue: false);
  }

  void setTheme() {
    configBox.put("Theme", !getDarkTheme());
    notifyListeners();
  }

  bool getSocketStatus() {
    return socketManager.socket.connected;
  }

  void setSocketStatus() {
    notifyListeners();
  }
}
