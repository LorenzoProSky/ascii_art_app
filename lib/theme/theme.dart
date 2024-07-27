import 'package:ascii_app/theme/app_color.dart';
import 'package:flutter/material.dart';

// AppTheme class to define the light and dark themes
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
        fontSize: 18.0,
        color: AppColor.black,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w300,
        fontSize: 18.0,
        color: AppColor.black,
      ),
      displayLarge: TextStyle(
        // TextTheme for the ASCII Art
        fontFamily: "Lucida Console",
        letterSpacing: 50,
        color: AppColor.black,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.black,
      selectionColor: AppColor.darkPurple.withAlpha(150),
      selectionHandleColor: AppColor.lightPurple,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    canvasColor: AppColor.darkBackground,
    primaryColor: AppColor.whiteOff,
    hintColor: AppColor.white,
    focusColor: AppColor.darkPurple,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w300,
        fontSize: 18.0,
        color: AppColor.black,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w300,
        fontSize: 18.0,
        color: AppColor.white,
      ),
      displayLarge: TextStyle(
        // TextTheme for the ASCII Art
        fontFamily: "Lucida Console",
        letterSpacing: 50,
        color: AppColor.white,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.white,
      selectionColor: AppColor.lightPurple.withAlpha(150),
      selectionHandleColor: AppColor.darkPurple,
    ),
  );
}
