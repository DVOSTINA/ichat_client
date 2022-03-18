import 'package:hive/hive.dart';
import 'package:ichat/database/news_db.dart';
import 'package:ichat/database/rooms_db.dart';

import '../data.dart';
import 'users_db.dart';
import 'groups_db.dart';
import 'messages_db.dart';

Box configBox = Hive.box(DatabaseName.config);
Box<User> usersBox = Hive.box<User>(DatabaseName.users);
Box<Room> roomsBox = Hive.box<Room>(DatabaseName.rooms);
Box<Message> messagesBox = Hive.box<Message>(DatabaseName.messages);
Box<News> newsBox = Hive.box<News>(DatabaseName.news);

Box<Group> groupsBox = Hive.box<Group>(DatabaseName.groups);
