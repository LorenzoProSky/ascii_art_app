import 'package:ascii_app/models/image_path_cache.dart';
import 'package:ascii_app/routes/home_page.dart';
import 'package:ascii_app/routes/image_page.dart';
import 'package:ascii_app/routes/image_page_camera.dart';
import 'package:ascii_app/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static const String homePage = "/";
  static const String imagePage = "/imagePage";
  static const String imageCameraPage = "/imageCameraPage";

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
      case imageCameraPage:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<ImagePathCache>(
            create: (_) => ImagePathCache(),
            child: const LoadingOverlay(
              child: ImageCameraPage(),
            ),
          ),
        );
      default:
        throw const FormatException("Route not found.");
    }
  }
}
