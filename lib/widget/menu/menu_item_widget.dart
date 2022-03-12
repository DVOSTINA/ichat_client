import 'package:flutter/material.dart';

import '../../styles/theme_data.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({
    Key? key,
    required this.icon,
    this.size = 24,
    required this.active,
    required this.onTap,
    required this.width,
  }) : super(key: key);

  final IconData icon;
  final double size;
  final bool active;
  final Function() onTap;

  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 3,
              color: getColorTheme(context).surface,
              style: active ? BorderStyle.solid : BorderStyle.none,
            ),
          ),
        ),
        child: Icon(
          icon,
          size: active ? size + 2 : size - 2,
          color: active ? getColorTheme(context).surface : getColorTheme(context).onSurface,
        ),
      ),
      onTap: onTap,
    );
  }
}
