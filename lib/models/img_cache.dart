// ignore_for_file: unnecessary_getters_setters
import 'package:flutter/foundation.dart';

class ImgCache with ChangeNotifier {
  String _imgPath = "";

  String get imgPath => _imgPath;
  set imgPath(String path) {
    _imgPath = path;
    notifyListeners();
  }
}
