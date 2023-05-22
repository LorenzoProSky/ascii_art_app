import 'package:ascii_app/models/notifiers/theme_notifier.dart';
import 'package:ascii_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(),
        child: const AsciiApp(),
      ),
    );

class AsciiApp extends StatelessWidget {
  const AsciiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ASCII Art Converter App",
      theme: Provider.of<ThemeProvider>(context).getTheme(),
      initialRoute: RouteGenerator.homePage,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
