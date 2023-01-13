import 'package:ascii_app/routes/home_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String homePage = "/";

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      default:
        throw const FormatException("Route not found.");
    }
  }
}
