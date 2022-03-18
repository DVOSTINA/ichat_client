import 'package:flutter/material.dart';
import 'package:ichat/database/messages_db.dart';
import 'package:ichat/provider/message_provider.dart';
import 'package:ichat/styles/theme_data.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../data/info.dart';
import '../data/server.dart';
import '../database/rooms_db.dart';
import '../database/users_db.dart';
import '../layout/message_room_layout.dart';
import '../provider/room_provider.dart';
import '../provider/user_provider.dart';
import '../widget/rooms_item_widget.dart';
import '../widget/top_menu/top_menu_widget.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  late Iterable<Room> rooms;

  @override
  Widget build(BuildContext context) {
    rooms = context.watch<RoomProvider>().getAllRoom();

    return Column(
      children: [
        //! Top Menu
        TopMenuWidget(
          title: widget.title,
          notifyCount: 5,
        ),
        //! Room List
        Expanded(
          child: Container(
            color: getColorTheme(context).secondary,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 5),
              shrinkWrap: true,
              itemBuilder: itemRoom,
              itemCount: rooms.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget itemRoom(BuildContext context, int index) {
    //! Config Item
    Room room = rooms.elementAt(index);
    int userId = room.creatorId == getMyInfo().id ? room.userId : room.creatorId;
    User user = context.watch<UserProvider>().getUser(userId);
    Message lastMessage = context.watch<MessageProvider>().getLastMessages(room.id);
    int countNotSeen = context.watch<MessageProvider>().getCountNotSeen(room.id);
    //! Make Item
    return RoomsItemWidget(
      title: user.getFullName(),
      lastMessage: lastMessage.file.isNotEmpty
          ? lastMessage.file.split('.')[1] == "png"
              ? "تصویر"
              : "فایل"
          : lastMessage.text,
      lastView: lastView(user.onlineAt)[0],
      isOnline: lastView(user.onlineAt)[1],
      countMessage: countNotSeen,
      profile: getIpProfile + user.profile,
      onTap: () {
        Navigator.pushNamed(
          context,
          MessageRoomLayout.pageId,
          arguments: {
            "roomId": room.id,
            "receiverId": user.id,
          },
        );
        // FlutterAppBadger.updateBadgeCount(1);
      },
    );
  }

  void searchButton() {}

  void notifyButton() {}
}
