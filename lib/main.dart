import 'package:ascii_app/models/image_path_cache.dart';
import 'package:ascii_app/routes.dart';
import 'package:ascii_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AsciiApp());

class AsciiApp extends StatelessWidget {
  const AsciiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImagePathCache>(
      create: (_) => ImagePathCache(),
      child: MaterialApp(
        title: "Ascii Image Converter App",
        theme: AppTheme.lightTheme,
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
