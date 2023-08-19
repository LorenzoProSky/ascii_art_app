import 'package:ascii_app/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    canvasColor: AppColor.lightBackground,
    primaryColor: AppColor.white,
    hintColor: AppColor.black,
    focusColor: AppColor.darkPurple,
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
        letterSpacing: 8,
        color: AppColor.black,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.black,
      selectionColor: AppColor.darkPurple.withAlpha(50),
      selectionHandleColor: AppColor.black,
    ),
  );

  static ThemeData darkTheme = ThemeData( //TODO
    brightness: Brightness.dark,
    canvasColor: AppColor.darkBackground,
    primaryColor: AppColor.black,
    hintColor: AppColor.white,
    focusColor: AppColor.lightPurple,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w300,
        fontSize: 20.0,
        color: AppColor.white,
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
      selectionColor: AppColor.lightPurple.withAlpha(50),
      selectionHandleColor: AppColor.white,
    ),
  );
}
