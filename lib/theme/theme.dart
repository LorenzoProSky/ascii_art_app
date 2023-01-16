import 'package:ascii_app/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();
  static ThemeData asciiAppTheme = ThemeData(
    backgroundColor: AppColor.background,
    primaryColor: AppColor.white,
    hintColor: AppColor.black,
    focusColor: AppColor.deepPurple,
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w200,
        fontSize: 40.0,
        color: AppColor.black,
      ),
      bodyText1: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w300,
        fontSize: 20.0,
        color: AppColor.black,
      ),
      subtitle1: TextStyle(
        // TextTheme for the ASCII Art
        fontFamily: "Lucida Console",
        letterSpacing: 5,
        color: AppColor.black,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.black,
      selectionColor: AppColor.deepPurple.withAlpha(50),
      selectionHandleColor: AppColor.black,
    ),
  );
}
