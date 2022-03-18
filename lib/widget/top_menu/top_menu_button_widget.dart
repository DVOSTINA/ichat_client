import 'package:flutter/material.dart';

import '../../styles/theme_data.dart';

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.count,
  }) : super(key: key);

  final IconData icon;
  final int count;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 71,
        height: 71,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: getColorTheme(context).onPrimary,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 5,
                      spreadRadius: 0,
                      color: Color.fromARGB(20, 0, 0, 0),
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 30,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Visibility(
                visible: count > 0,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getColorTheme(context).surface,
                  ),
                  child: Center(
                    child: Text(
                      count <= 9 ? count.toString() : "9+",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
