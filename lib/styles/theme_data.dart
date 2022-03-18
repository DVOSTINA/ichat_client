import 'package:flutter/material.dart';

//! Public Color
const Color lightBlueColorLight = Color(0xFF0CCBFF);
const Color darkBlueColorLight = Color(0xFF0975F3);
const Color iconDarkColor = Color(0xFF000000);
const Color iconLightColor = Color(0xFFFFFFFF);
const Color textDarkColor = Color(0xFF000000);
const Color textLightColor = Color(0xFFFFFFFF);

//! Dark Color
const Color firstColorDark = Color(0xFF262626);
const Color secondColorDark = Color(0xff181818);
const Color thirdColorDark = Color(0xFF3B3B3B);
const Color fourthColorDark = Color(0xFF3A3A3A);
const Color fifthColorDark = Color(0xFF4B4B4B);
const Color onlineColorDark = Color(0xFF3C95E3);
const Color activeColorDark = Color(0xff3C95E3);
const Color inActiveColorDark = Color(0xFF8A8A8A);

//! Light Color
const Color firstColorLight = Color(0xFFF5F5F5);
const Color secondColorLight = Color(0xFFEBEBEB);
const Color thirdColorLight = Color(0xFFFFFFFF);
const Color fourthColorLight = Color(0xFF979797);
const Color fifthColorLight = Color(0xFF112027);
const Color onlineColorLight = Color(0xff3C95E3);
const Color activeColorLight = Color(0xff3C95E3);
const Color inActiveColorLight = Color(0xFF8A8A8A);

ColorScheme getColorTheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}

TextTheme getTextTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

IconThemeData getIconTheme(BuildContext context) {
  return Theme.of(context).iconTheme;
}
