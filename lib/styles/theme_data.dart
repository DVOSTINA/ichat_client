import 'package:flutter/material.dart';

//! Public Color
const Color lightBlueColorLight = Color(0xFF0CCBFF);
const Color darkBlueColorLight = Color(0xFF0975F3);
const Color iconDarkColor = Color(0xFF000000);
const Color iconLightColor = Color(0xFFFFFFFF);
const Color textDarkColor = Color(0xFF000000);
const Color textLightColor = Color(0xFFFFFFFF);

//! Dark Color
const Color firstColorDark = Color(0xFF12121E);
const Color secondColorDark = Color(0xff0C0B15);
const Color thirdColorDark = Color(0xFF232633);
const Color fourthColorDark = Color(0xFF3A3A3A);
const Color fifthColorDark = Color(0xFF4B4B4B);
const Color onlineColorDark = Color(0xFF2e94e5);
const Color activeColorDark = Color(0xff5653E6);
const Color inActiveColorDark = Color(0xFF7E7DA8);

//! Light Color
const Color firstColorLight = Color(0xFFFFFFFF);
const Color secondColorLight = Color(0xFFF7F7F7);
const Color thirdColorLight = Color(0xFF0CCBFF);
const Color fourthColorLight = Color(0xFF0975F3);
const Color fifthColorLight = Color(0xFF112027);
const Color onlineColorLight = Color(0xFF2e94e5);
const Color activeColorLight = Color(0xFF286dfb);
const Color inActiveColorLight = Color(0xFFD4D1DC);

ColorScheme getColorTheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}

TextTheme getTextTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

IconThemeData getIconTheme(BuildContext context) {
  return Theme.of(context).iconTheme;
}
