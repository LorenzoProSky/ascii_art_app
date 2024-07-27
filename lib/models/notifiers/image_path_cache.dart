import 'package:flutter/foundation.dart';

// Image path cache: cache the image path to pass it around the app
class ImagePathCache with ChangeNotifier {
  String _imagePath = "";

  String get imagePath => _imagePath;
  set imagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }
}
