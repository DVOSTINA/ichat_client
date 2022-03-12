import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    Key? key,
    required this.color,
    required this.backgroundColor,
    this.size = 30,
    this.stroke = 4,
  }) : super(key: key);

  final Color backgroundColor;
  final Color color;
  final double? size;
  final double? stroke;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        backgroundColor: backgroundColor,
        strokeWidth: stroke!,
        color: color,
      ),
    );
  }
}
