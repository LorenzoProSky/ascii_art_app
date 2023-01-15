import 'package:ascii_app/routes/routes.dart';
import 'package:ascii_app/theme/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AsciiApp());

// TODO Error Handling

class AsciiApp extends StatelessWidget {
  const AsciiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ASCII Art Converter App",
      theme: AppTheme.asciiAppTheme,
      initialRoute: RouteGenerator.homePage,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
