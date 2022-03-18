import 'package:flutter/material.dart';

import 'theme_data.dart';
import 'theme_text_light.dart';

ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: secondColorLight,
  dividerColor: fourthColorLight,
  colorScheme: const ColorScheme.light(
    primary: firstColorLight,
    secondary: secondColorLight,
    onPrimary: thirdColorLight,
    onSecondary: fourthColorLight,
    primaryContainer: Colors.black,
    secondaryContainer: Colors.white,
    surface: activeColorLight,
    onSurface: inActiveColorLight,
    tertiary: onlineColorLight,
  ),
  fontFamily: 'Vazir',
  textTheme: themeTextLight,
  iconTheme: const IconThemeData(
    color: iconDarkColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: iconDarkColor,
  ),
);
