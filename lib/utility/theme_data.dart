import 'package:flutter/material.dart';
import 'package:grocery_app/utility/constant.dart';

class MyThemeData {
  static final darkTheme = ThemeData(
    fontFamily: 'OnePlus-Regular',
    scaffoldBackgroundColor: kDarkColor,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
  );

  static final lightTheme = ThemeData(
    fontFamily: 'OnePlus-Regular',
    scaffoldBackgroundColor: kLightColor,
    primaryColor: Colors.white,
    appBarTheme: const AppBarTheme(backgroundColor: kCarrotColor),
    colorScheme: const ColorScheme.light(),
  );
}
