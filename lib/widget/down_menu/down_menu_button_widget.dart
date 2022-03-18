import 'package:flutter/material.dart';
import 'package:ichat/styles/theme_data.dart';

class DownMenuButtonWidget extends StatelessWidget {
  const DownMenuButtonWidget({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.isActive,
    required this.width,
  }) : super(key: key);

  final IconData icon;
  final void Function() onTap;
  final bool isActive;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              width: isActive ? 3 : 0,
              color: getColorTheme(context).surface,
              style: isActive ? BorderStyle.solid : BorderStyle.none,
            ),
          ),
        ),
        child: Icon(
          icon,
          color: isActive ? getColorTheme(context).surface : getColorTheme(context).onSurface,
        ),
      ),
    );
  }
}
