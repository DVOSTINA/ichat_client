import 'package:flutter/material.dart';

import '../styles/theme_data.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.title,
    required this.status,
    required this.showStatus,
    required this.icon,
    this.onConnect,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final String status;
  final bool showStatus;

  final Function()? onConnect;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        color: getColorTheme(context).secondary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onConnect,
              child: Visibility(
                visible: showStatus,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      status,
                      textAlign: TextAlign.left,
                      style: getTextTheme(context).headline3,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.right,
              style: getTextTheme(context).headline3,
            ),
          ],
        ),
      ),
    );
  }
}
