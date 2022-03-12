import 'package:flutter/material.dart';
import 'package:ichat/database/groups_db.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../provider/config_provider.dart';
import '../provider/group_provider.dart';
import '../widget/contacts_item_widget.dart';
import '../widget/header_widget.dart';
import '../styles/theme_data.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<GroupsPage> createState() => _ChannelState();
}

class _ChannelState extends State<GroupsPage> {
  late String search = '';

  @override
  Widget build(BuildContext context) {
    Iterable<Group> groups = context.watch<GroupProvider>().getAllGroup(search: search);

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
              hintText: "نام کانال یا گروه",
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
                Group group = groups.elementAt(index);
                // //! Make Item
                return ContactsItemWidget(
                  isUser: false,
                  title: group.title,
                  text: group.description,
                  isChannel: group.type,
                  profileUrl: 'getIpProfile(false) + group.id.toString() + ".jpg"',
                  onTap: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   MessageGroupLayout.pageId,
                    //   arguments: {
                    //     "id": group.id,
                    //     "isChannel": group.type,
                    //   },
                    // );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(height: 0);
              },
              itemCount: groups.length, //getUserOnSearch().length,
            ),
          ),
        ),
      ],
    );
  }
}
