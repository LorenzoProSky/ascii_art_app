import 'package:ascii_app/routes/home_page.dart';
import 'package:ascii_app/routes/image_page.dart';
import 'package:ascii_app/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/image_path_cache.dart';

class RouteGenerator {
  static const String homePage = "/";
  static const String imagePage = "/imagePage";

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case imagePage:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<ImagePathCache>(
            create: (_) => ImagePathCache(),
            child: const LoadingOverlay(
              child: ImagePage(),
            ),
          ),
        );
      default:
        throw const FormatException("Route not found.");
    }
  }
}
