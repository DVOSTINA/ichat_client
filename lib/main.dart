import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ichat/database/groups_db.dart';
import 'package:ichat/database/messages_db.dart';
import 'package:ichat/layout/notify_layout.dart';
import 'package:ichat/layout/school_layout.dart';
import 'package:ichat/provider/news_provider.dart';
import 'package:provider/provider.dart';

import 'data.dart';
import 'database/news_db.dart';
import 'database/rooms_db.dart';
import 'layout/error_layout.dart';
import 'layout/login_layout.dart';
import 'layout/main_layout.dart';
import 'layout/loader_layout.dart';
import 'database/users_db.dart';
import 'layout/message_room_layout.dart';
import 'layout/profile_layout.dart';
import 'provider/group_provider.dart';
import 'provider/message_provider.dart';
import 'provider/user_provider.dart';
import 'styles/theme_light.dart';
import 'styles/theme_dark.dart';
import 'provider/config_provider.dart';
import 'provider/room_provider.dart';

Future<void> hiveConfig() async {
  //! Hive Config
  await Hive.initFlutter();
  //! Hive Adapter
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(GroupAdapter());
  Hive.registerAdapter(RoomAdapter());
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(NewsAdapter());
  //! Hive Open
  await Hive.openBox(DatabaseName.config);
  await Hive.openBox<User>(DatabaseName.users);
  await Hive.openBox<Room>(DatabaseName.rooms);
  await Hive.openBox<Group>(DatabaseName.groups);
  await Hive.openBox<Message>(DatabaseName.messages);
  await Hive.openBox<News>(DatabaseName.news);
}

Future<void> main() async {
  //! App Init
  WidgetsFlutterBinding.ensureInitialized();

  //! Hive Config
  await hiveConfig();

  // //! URL Config
  // setPathUrlStrategy();

  //! Run App
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConfigProvider()),
        ChangeNotifierProvider(create: (_) => RoomProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
        ChangeNotifierProvider(create: (_) => MessageProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I Chat',
      debugShowCheckedModeBanner: false,
      theme: context.watch<ConfigProvider>().getDarkTheme() ? themeDark : themeLight,
      initialRoute: LoaderLayout.pageId,
      routes: {
        LoaderLayout.pageId: (context) => const LoaderLayout(),
        LoginLayout.pageId: (context) => const LoginLayout(),
        ErrorLayout.pageId: (context) => const ErrorLayout(),
        MainLayout.pageId: (context) => const MainLayout(),
        NotifyLayout.pageId: (context) => const NotifyLayout(),
        SchoolLayout.pageId: (context) => const SchoolLayout(),
        ProfileLayout.pageId: (context) => const ProfileLayout(),
        MessageRoomLayout.pageId: (context) => const MessageRoomLayout(),
      },
    );
  }
}
