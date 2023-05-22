import 'package:ascii_app/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    canvasColor: AppColor.lightBackground,
    primaryColor: AppColor.white,
    hintColor: AppColor.black,
    focusColor: AppColor.deepPurple,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w300,
        fontSize: 20.0,
        color: AppColor.black,
      ),
      displayLarge: TextStyle(
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

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    canvasColor: AppColor.darkBackground,
    primaryColor: AppColor.white,
    hintColor: AppColor.black,
    focusColor: AppColor.deepPurple,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w300,
        fontSize: 20.0,
        color: AppColor.black,
      ),
      displayLarge: TextStyle(
        // TextTheme for the ASCII Art
        fontFamily: "Lucida Console",
        letterSpacing: 5,
        color: AppColor.white,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.white,
      selectionColor: AppColor.deepPurple.withAlpha(50),
      selectionHandleColor: AppColor.white,
    ),
  );
}
