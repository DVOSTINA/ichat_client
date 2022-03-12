import 'package:flutter/material.dart';

import '../../data.dart';
import 'menu_item_widget.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    Key? key,
    required this.height,
    required this.backgroundColor,
    required this.items,
    required this.onTaps,
  }) : super(key: key);

  final double height;
  final Color backgroundColor;
  final List<PageData> items;
  final List<Function()> onTaps;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getSizeScreenSafe(context).width,
      height: height,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        color: backgroundColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 15,
            spreadRadius: 0,
            color: Color.fromARGB(30, 0, 0, 0),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return MenuItemWidget(
            width: getSizeScreenSafe(context).width / onTaps.length,
            size: 30,
            icon: items[index].icon,
            active: items[index].active,
            onTap: onTaps[index],
          );
        },
        itemCount: onTaps.length,
      ),
    );
  }
}
