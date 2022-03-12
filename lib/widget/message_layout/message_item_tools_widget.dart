import 'package:flutter/material.dart';

import '../../styles/theme_data.dart';

class MessageItemToolsWidget extends StatelessWidget {
  const MessageItemToolsWidget({
    Key? key,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: getColorTheme(context).secondary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 17,
        ),
      ),
      onTap: onTap,
    );
  }
}
