import 'package:flutter/material.dart';

import '../../styles/theme_data.dart';

class MessageJumpToEndWidget extends StatelessWidget {
  const MessageJumpToEndWidget({
    Key? key,
    required this.visible,
    required this.onTap,
  }) : super(key: key);

  final bool visible;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: visible ? 1 : 0,
      alignment: Alignment.bottomCenter,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 500),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getColorTheme(context).secondary,
            ),
            child: const Icon(
              Icons.arrow_downward,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
