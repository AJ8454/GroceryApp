import 'package:flutter/material.dart';
import 'package:grocery_app/utility/constant.dart';

class MyThemeData {
  static final darkTheme = ThemeData(
    fontFamily: 'OnePlus-Regular',
    scaffoldBackgroundColor: kDarkColor,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.dark(),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Colors.transparent),
  );

  static final lightTheme = ThemeData(
    fontFamily: 'OnePlus-Regular',
    scaffoldBackgroundColor: kLightColor,
    primaryColor: Colors.black,
    appBarTheme: const AppBarTheme(backgroundColor: kCarrotColor),
    colorScheme: const ColorScheme.light(),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kCarrotColor,
    ),
  );
}
