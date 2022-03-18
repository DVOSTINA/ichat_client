import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DatabaseName {
  static String config = "config";
  static String users = "Users";
  static String groups = "Groups";
  static String rooms = "rooms";
  static String news = "news";
  static String messages = "messages";
}

Size getSizeScreen(BuildContext context) {
  return MediaQuery.of(context).size;
}

Size getSizeScreenSafe(BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  EdgeInsets padding = MediaQuery.of(context).padding;

  Size size = Size(
    screenSize.width - padding.left - padding.right,
    screenSize.height - padding.top - padding.bottom,
  );

  return size;
}

EdgeInsets getSizeSafe(BuildContext context) {
  return MediaQuery.of(context).padding;
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class PageData {
  PageData({
    required this.icon,
    required this.active,
    required this.widget,
  });

  late IconData icon;
  late bool active;
  late Widget widget;
}

List<dynamic> lastView(int time) {
  if (time == 0) {
    return ["آنلاین", true];
  } else {
    DateTime timeStamp = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    Duration timeDifference = DateTime.now().difference(timeStamp);

    if (timeDifference.inDays > 0) {
      int inDays = timeDifference.inDays;
      return ["$inDays روز قبل", false];
    } else if (timeDifference.inHours > 0) {
      int inHours = timeDifference.inHours;
      return ["$inHours ساعت قبل", false];
    } else if (timeDifference.inMinutes > 0) {
      int inMinutes = timeDifference.inMinutes;
      return ["$inMinutes دقیقه قبل", false];
    } else if (timeDifference.inSeconds > 0) {
      int inSeconds = timeDifference.inSeconds;
      return ["$inSeconds ثانیه قبل", false];
    } else {
      return ["چند لحظه قبل", false];
    }
  }
}

void createNotify(int id, String title, String body) {
  FlutterLocalNotificationsPlugin flutterNotificationPlugin = FlutterLocalNotificationsPlugin();
  flutterNotificationPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/icon'),
      iOS: IOSInitializationSettings(),
    ),
    onSelectNotification: (payload) {
      debugPrint(payload);
    },
  );
  flutterNotificationPlugin.show(
    id,
    title,
    body,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        '0',
        'New Messages',
        channelDescription: 'Receive a new message',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: IOSNotificationDetails(),
    ),
    payload: id.toString(),
  );
}

dynamic getArguments(BuildContext context, String argument) {
  dynamic arguments = ModalRoute.of(context)?.settings.arguments;
  return arguments[argument] ?? 0;
}
