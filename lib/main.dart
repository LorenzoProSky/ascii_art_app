import 'package:ascii_app/routes/routes.dart';
import 'package:ascii_app/theme/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AsciiApp());

class AsciiApp extends StatelessWidget {
  const AsciiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ASCII Art Converter App",
      theme: AppTheme.lightTheme,
      initialRoute: RouteGenerator.homePage,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
