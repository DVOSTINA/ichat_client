import 'package:flutter/material.dart';

import '../styles/theme_data.dart';

class ButtonContactsWidget extends StatelessWidget {
  const ButtonContactsWidget({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          color: getColorTheme(context).secondary,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }
}
