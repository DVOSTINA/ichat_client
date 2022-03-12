import 'package:flutter/material.dart';
import 'package:ichat/provider/config_provider.dart';
import 'package:ichat/styles/theme_data.dart';
import 'package:provider/provider.dart';
import '../widget/header_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Header
        HeaderWidget(
          title: widget.title,
          status: "درحال اتصال",
          icon: Icons.wifi_rounded,
          showStatus: !context.watch<ConfigProvider>().getSocketStatus(),
          onConnect: () {},
        ),
        //! History
        Container(
          margin: const EdgeInsets.all(20),
          child: Text(
            "این بخش هنوز ساخته نشده است",
            style: getTextTheme(context).headline1,
          ),
        ),
      ],
    );
  }

  // Contact getContact(int index) {
  //   return contacts.values.singleWhere((element) {
  //     return element.userName.toString() == historys.values.elementAt(index).userName;
  //   });
  // }

  // Group getGroup(int id) {
  //   return groups.values.singleWhere((element) => element.id == id);
  // }
}
