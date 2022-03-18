import 'package:flutter/material.dart';
import 'package:ichat/data.dart';

import '../../styles/theme_data.dart';

class NotifyHeaderWidget extends StatelessWidget {
  const NotifyHeaderWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50 + getSizeSafe(context).top,
      padding: EdgeInsets.only(top: getSizeSafe(context).top),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        color: getColorTheme(context).primary,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 5,
            spreadRadius: 0,
            color: Color.fromARGB(10, 0, 0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  icon,
                ),
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: getTextTheme(context).headline3,
            ),
          ],
        ),
      ),
    );
  }
}
