import 'package:ascii_app/models/notifiers/image_path_cache.dart';
import 'package:ascii_app/routes/home_page.dart';
import 'package:ascii_app/routes/image_page/image_page.dart';
import 'package:ascii_app/routes/image_page/image_page_arguments.dart';
import 'package:ascii_app/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          builder: (context) => ChangeNotifierProvider<ImagePathCache>(
            create: (_) => ImagePathCache(),
            child: LoadingOverlay(
              child: ImagePage(settings.arguments as ImagePageArguments),
            ),
          ),
        );
      default:
        throw const FormatException("Route not found.");
    }
  }
}
