import 'package:ascii_app/theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = AppTheme.lightTheme;

  ThemeProvider() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;

    _themeData = brightness == Brightness.dark
        ? AppTheme.darkTheme
        : AppTheme.lightTheme;
  }

  ThemeData getTheme() => _themeData;

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
