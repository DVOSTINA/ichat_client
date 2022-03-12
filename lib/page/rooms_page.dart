import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ichat/database/messages_db.dart';
import 'package:ichat/provider/message_provider.dart';
import 'package:ichat/styles/theme_data.dart';
import 'package:ichat/widget/contacts_item_widget.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../data/info.dart';
import '../data/server.dart';
import '../database/rooms_db.dart';
import '../database/users_db.dart';
import '../layout/message_user_layout.dart';
import '../provider/room_provider.dart';
import '../provider/user_provider.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<RoomsPage> {
  late Iterable<Room> rooms;

  @override
  Widget build(BuildContext context) {
    rooms = context.watch<RoomProvider>().getAllRoom();

    return Column(
      children: [
        TopMenuWidget(
          title: widget.title,
          notifyCount: 5,
          onNotifyTap: () {},
          onSchoolTap: () {},
        ),
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
    return ContactsItemWidget(
      isUser: true,
      title: user.getFullName(),
      text: lastMessage.file.isNotEmpty
          ? lastMessage.file.split('.')[1] == "png"
              ? "تصویر"
              : "فایل"
          : lastMessage.text,
      isChannel: false,
      lastView: lastView(user.onlineAt)[0],
      online: lastView(user.onlineAt)[1],
      countMessage: countNotSeen,
      profileUrl: getIpProfile + user.profile,
      onTap: () {
        Navigator.pushNamed(
          context,
          MessageUserLayout.pageId,
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

class TopMenuWidget extends StatelessWidget {
  const TopMenuWidget({
    Key? key,
    required this.title,
    this.notifyCount = 0,
    required this.onNotifyTap,
    required this.onSchoolTap,
  }) : super(key: key);

  final String title;
  final int notifyCount;
  final void Function() onNotifyTap;
  final void Function() onSchoolTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TopMenuButtonWidget(
            icon: Icons.notifications_outlined,
            count: notifyCount,
            onTap: onNotifyTap,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: getTextTheme(context).headline1,
          ),
          TopMenuButtonWidget(
            icon: Icons.school_outlined,
            count: 0,
            onTap: onSchoolTap,
          ),
        ],
      ),
    );
  }
}

class TopMenuButtonWidget extends StatelessWidget {
  const TopMenuButtonWidget({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.count,
  }) : super(key: key);

  final IconData icon;
  final int count;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 70,
        height: 70,
        child: Stack(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: getColorTheme(context).onPrimary,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    spreadRadius: 0,
                    color: Color.fromARGB(150, 0, 0, 0),
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 30,
              ),
            ),
            Visibility(
              visible: count > 0,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getColorTheme(context).surface,
                  ),
                  child: Center(
                    child: Text(
                      count <= 9 ? count.toString() : "9+",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
