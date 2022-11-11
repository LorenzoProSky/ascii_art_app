// ignore_for_file: unnecessary_getters_setters

import 'dart:typed_data';

class ImgCache {
  Uint8List _imgCache = Uint8List(0);
  String _imgPath = "";

  Uint8List get imgCache => _imgCache;
  set imgCache(Uint8List image) {
    _imgCache = image;
  }

  String get imgPath => _imgPath;
  set imgPath(String path) {
    _imgPath = path;
  }
}
