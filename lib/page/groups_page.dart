import 'package:flutter/material.dart';
import 'package:ichat/styles/theme_data.dart';

import '../data.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<GroupsPage> {
  @override
  Widget build(BuildContext context) {
    // int listCount = context.watch<RoomProvider>().getCountGroupHistory();

    return Column(
      children: [
        //! Header
        // NotifyHeaderWidget(
        //   title: widget.title,
        //   status: "درحال اتصال",
        //   icon: Icons.wifi_rounded,
        //   showStatus: !context.watch<ConfigProvider>().getSocketStatus(),
        //   onConnect: () {},
        // ),
        //! History
        ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: 0 == 0
              ? Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    "تاریخچه شما خالی است",
                    style: getTextTheme(context).headline1,
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  itemBuilder: (context, index) {
                    return const SizedBox();
                    // //! Config Item
                    // History history = context.watch<HistoryProvider>().getGroupHistory(index);
                    // int historyId = history.creatorId == getMyInfo().id ? history.userId : history.creatorId;
                    // Group group = context.watch<GroupProvider>().getGroup(historyId);
                    // int countNotSeen = context.watch<MessageProvider>().getCountNotSeen(historyId);
                    // //! Make Item
                    // return ContactsItemWidget(
                    //   isUser: false,
                    //   title: group.title,
                    //   text: group.description,
                    //   isChannel: group.type,
                    //   lastView: '',
                    //   online: false,
                    //   countMessage: countNotSeen,
                    //   profileUrl: 'getIpProfile(false) + group.id.toString() + ".jpg"',
                    //   onTap: () {
                    //     // Navigator.pushNamed(
                    //     //   context,
                    //     //   MessageGroupLayout.pageId,
                    //     //   arguments: {
                    //     //     "id": group.id,
                    //     //     "isChannel": group.type,
                    //     //   },
                    //     // );
                    //   },
                    // );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(height: 0);
                  },
                  itemCount: 0,
                ),
        ),
      ],
    );
  }
}
