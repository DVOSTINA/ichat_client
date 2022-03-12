import 'package:flutter/material.dart';

import 'theme_data.dart';
import 'theme_text_light.dart';

ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: thirdColorLight,
  dividerColor: secondColorLight,
  colorScheme: const ColorScheme.light(
    primary: firstColorLight,
    secondary: secondColorLight,
    onPrimary: secondColorLight,
    onSecondary: fourthColorLight,
    secondaryContainer: fifthColorLight,
    primaryContainer: secondColorLight,
    surface: activeColorLight,
    onSurface: inActiveColorLight,
    tertiary: Colors.white,
    onTertiary: Colors.black,
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
