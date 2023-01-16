import 'package:ascii_app/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();
  static ThemeData asciiAppTheme = ThemeData(
    colorScheme: const ColorScheme(
      background: AppColor.background,
      brightness: Brightness.light,
      error: AppColor.background,
      onBackground: AppColor.white,
      onError: AppColor.background,
      onPrimary: AppColor.black,
      onSecondary: AppColor.background,
      onSurface: AppColor.background,
      primary: AppColor.white,
      secondary: AppColor.deepPurple,
      surface: AppColor.background,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w200,
        fontSize: 38.0,
        color: AppColor.black,
      ),
      bodyText1: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w300,
        fontSize: 18.0,
        color: AppColor.black,
      ),
      bodyText2: TextStyle(
        fontFamily: "Lucida Console",
        letterSpacing: 5,
        color: AppColor.black,
      ),
    ),
    
  );
}
