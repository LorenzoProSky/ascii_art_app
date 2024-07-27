import 'package:ascii_app/models/notifiers/theme_notifier.dart';
import 'package:ascii_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Portrait mode only
  ]).then((_) => runApp(
        // Provide the ThemeProvider to the widget tree
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
          child: const AsciiApp(),
        ),
      ));
}

class AsciiApp extends StatelessWidget {
  const AsciiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ASCII Art Converter App",
      // Get the theme from the ThemeProvider
      theme: Provider.of<ThemeProvider>(context).getTheme(),
      themeMode: ThemeMode.light,
      initialRoute: RouteGenerator.homePage,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
