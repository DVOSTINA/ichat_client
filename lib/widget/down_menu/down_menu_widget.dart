import 'package:flutter/material.dart';
import 'package:ichat/data.dart';
import 'package:ichat/styles/theme_data.dart';
import 'package:ichat/widget/down_menu/down_menu_button_widget.dart';

class DownMenuWidget extends StatelessWidget {
  const DownMenuWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final List<DownMenuButtonWidget> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getSizeScreenSafe(context).width,
      height: 60 + getSizeSafe(context).bottom,
      padding: EdgeInsets.only(bottom: getSizeSafe(context).bottom),
      decoration: BoxDecoration(
        color: getColorTheme(context).primary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 10,
            spreadRadius: 0,
            color: Color.fromARGB(30, 0, 0, 0),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return item[index];
        },
        itemCount: item.length,
      ),
    );
  }
}
