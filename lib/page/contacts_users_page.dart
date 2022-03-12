import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../data/server.dart';
import '../database/users_db.dart';
import '../layout/message_user_layout.dart';
import '../provider/config_provider.dart';
import '../provider/user_provider.dart';
import '../widget/contacts_item_widget.dart';
import '../widget/header_widget.dart';
import '../styles/theme_data.dart';

class UsersContactsPage extends StatefulWidget {
  const UsersContactsPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<UsersContactsPage> createState() => _ContactsState();
}

class _ContactsState extends State<UsersContactsPage> {
  bool isNumber = false;
  late String search = '';

  @override
  Widget build(BuildContext context) {
    Iterable<User> users = context.watch<UserProvider>().getAllUser(search: search);

    return Column(
      children: [
        //! Header
        HeaderWidget(
          title: widget.title,
          status: "درحال اتصال",
          icon: Icons.wifi_rounded,
          showStatus: !context.watch<ConfigProvider>().getSocketStatus(),
        ),
        //! Search
        Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: getColorTheme(context).onPrimary,
            ),
            color: getColorTheme(context).primary,
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
        const Divider(height: 0),
        //! History
        Expanded(
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: ListView.separated(
              shrinkWrap: true,
              controller: ScrollController(),
              itemBuilder: (context, index) {
                //! Config Item
                User user = users.elementAt(index);
                //! Make Item
                return ContactsItemWidget(
                  isUser: true,
                  title: user.getFullName(),
                  text: user.bio,
                  lastView: lastView(user.onlineAt)[0],
                  online: lastView(user.onlineAt)[1],
                  profileUrl: getIpProfile + user.profile,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MessageUserLayout.pageId,
                      arguments: {
                        "id": user.id,
                      },
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(height: 0);
              },
              itemCount: users.length, //getUserOnSearch().length,
            ),
          ),
        ),
      ],
    );
  }
}
