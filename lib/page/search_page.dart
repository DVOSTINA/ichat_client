import 'package:flutter/material.dart';
import 'package:ichat/styles/theme_data.dart';
import '../widget/top_menu/top_menu_widget.dart';

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
        //! Top Menu
        TopMenuWidget(
          title: widget.title,
        ),
        //! History
        Expanded(
          child: Container(
            color: getColorTheme(context).secondary,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "این بخش هنوز ساخته نشده است",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: getTextTheme(context).headline3,
                  ),
                ),
              ],
            ),
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
