import 'package:flutter/material.dart';

import 'theme_data.dart';
import 'theme_text_dark.dart';

ThemeData themeDark = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: secondColorDark,
  dividerColor: secondColorDark,
  colorScheme: const ColorScheme.dark(
    primary: firstColorDark,
    secondary: secondColorDark,
    onPrimary: thirdColorDark,
    onSecondary: fourthColorDark,
    primaryContainer: Colors.white,
    secondaryContainer: Colors.black,
    surface: activeColorDark,
    onSurface: inActiveColorDark,
    tertiary: onlineColorLight,
  ),
  fontFamily: 'Vazir',
  textTheme: themeTextDark,
  iconTheme: const IconThemeData(
    color: iconLightColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: iconLightColor,
  ),
);
