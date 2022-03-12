import 'package:flutter/material.dart';

import 'theme_data.dart';
import 'theme_text_dark.dart';

ThemeData themeDark = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: firstColorDark,
  dividerColor: secondColorDark,
  colorScheme: const ColorScheme.dark(
    primary: firstColorDark,
    secondary: secondColorDark,
    onPrimary: thirdColorDark,
    onSecondary: fourthColorDark,
    secondaryContainer: fifthColorDark,
    primaryContainer: secondColorDark,
    surface: activeColorDark,
    onSurface: inActiveColorDark,
    tertiary: Colors.black,
    onTertiary: Colors.white,
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
