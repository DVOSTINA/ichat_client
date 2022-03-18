import 'package:flutter/material.dart';
import 'package:ichat/provider/room_provider.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../data/server.dart';
import '../database/rooms_db.dart';
import '../database/users_db.dart';
import '../layout/message_room_layout.dart';
import '../provider/user_provider.dart';
import '../widget/contacts_item_widget.dart';
import '../styles/theme_data.dart';
import '../widget/top_menu/top_menu_widget.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<ContactsPage> createState() => _ContactsState();
}

class _ContactsState extends State<ContactsPage> {
  bool isNumber = false;
  late String search = '';

  late Iterable<User> users;

  @override
  Widget build(BuildContext context) {
    users = context.watch<UserProvider>().getAllUser(search: search);

    return Column(
      children: [
        //! Top Menu
        TopMenuWidget(
          title: widget.title,
          notifyCount: 5,
        ),
        //! Search
        Container(
          color: getColorTheme(context).primary,
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: getColorTheme(context).onSecondary,
              ),
              color: getColorTheme(context).secondary,
            ),
            child: TextField(
              autofocus: false,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              cursorColor: getColorTheme(context).onSecondary,
              style: getTextTheme(context).bodyText2,
              decoration: InputDecoration(
                hintText: "نام , فامیل , کد ملی",
                hintTextDirection: TextDirection.rtl,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: getTextTheme(context).bodyText1,
              ),
              onChanged: (value) {
                setState(() {
                  search = value.trim();
                });
              },
            ),
          ),
        ),
        //! Contacts List
        Expanded(
          child: Container(
            width: getSizeScreenSafe(context).width,
            color: getColorTheme(context).secondary,
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 5),
              controller: ScrollController(),
              itemBuilder: itemContact,
              itemCount: users.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget itemContact(BuildContext context, int index) {
    //! Config Item
    User user = users.elementAt(index);
    Room room = context.watch<RoomProvider>().getRoomByUserId(user.id);
    //! Make Item
    return ContactsItemWidget(
      title: user.getFullName(),
      bio: user.bio,
      lastView: lastView(user.onlineAt)[0],
      isOnline: lastView(user.onlineAt)[1],
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
      },
    );
  }
}
