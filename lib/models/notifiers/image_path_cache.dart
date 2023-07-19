// ignore_for_file: unnecessary_getters_setters
import 'package:flutter/foundation.dart';

class ImagePathCache with ChangeNotifier {
  String _imagePath = "";

  String get imagePath => _imagePath;
  set imagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }
}