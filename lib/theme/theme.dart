import 'package:ascii_app/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();
  static ThemeData asciiAppTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      background: AppColor.background,
      onBackground: AppColor.white,
      primary: AppColor.white,
      onPrimary: AppColor.black,
      secondary: AppColor.deepPurple,
      onSecondary: AppColor.white,
      surface: AppColor.background,
      onSurface: AppColor.black,
      error: AppColor.red,
      onError: AppColor.black,
    ),
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
  );
}
