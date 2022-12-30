import 'package:ascii_app/models/img_cache.dart';
import 'package:ascii_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AsciiApp());

class AsciiApp extends StatelessWidget {
  const AsciiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImgCache>(
      create: (_) => ImgCache(),
      child: MaterialApp(
        title: "Ascii Image Converter App",
        theme: ThemeData(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w200,
              fontSize: 38.0,
              color: Color.fromARGB(250, 29, 29, 29),
            ),
            bodyText1: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w300,
              fontSize: 18.0,
              color: Color.fromARGB(250, 29, 29, 29),
            ),
            bodyText2: TextStyle(
              fontFamily: "Lucida Console",
              letterSpacing: 5,
              color: Color.fromARGB(250, 29, 29, 29),
            ),
          ),
        ),
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
