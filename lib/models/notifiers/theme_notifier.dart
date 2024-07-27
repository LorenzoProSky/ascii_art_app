import 'package:ascii_app/theme/theme.dart';
import 'package:flutter/material.dart';

// Theme provider: provide the theme to the widget tree
class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = AppTheme.lightTheme; // Default theme

  ThemeProvider();

  ThemeData getTheme() => _themeData;

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
