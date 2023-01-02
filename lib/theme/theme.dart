import 'package:ascii_app/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
    backgroundColor: AppColor.background,
    primaryColor: AppColor.background,
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w200,
        fontSize: 38.0,
        color: AppColor.textColor,
      ),
      bodyText1: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w300,
        fontSize: 18.0,
        color: AppColor.textColor,
      ),
      bodyText2: TextStyle(
        fontFamily: "Lucida Console",
        letterSpacing: 5,
        color: AppColor.textColor,
      ),
    ),

    cardTheme: const CardTheme(color: AppColor.background),
    iconTheme: const IconThemeData(color: AppColor.iconColor),
    bottomAppBarColor: AppColor.background,
    dividerColor: AppColor.lightGrey,
  );

  static List<BoxShadow> shadow = <BoxShadow>[
    const BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];

  static EdgeInsets padding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(
    horizontal: 10,
  );

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
