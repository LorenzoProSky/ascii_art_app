import 'dart:io';

import 'package:ascii_app/models/ascii_characters_brightness.dart';
import 'package:image/image.dart';

class Asciifier {
  // TODO Errors
  static Future<String> asciify(
      String path, int sensibility, int charSensibility) async {
    var startImg = decodeImage(File(path).readAsBytesSync());
    // Min value of sensibility = 1
    var chProcessor = AsciiCharactersBrightness(charSensibility);
    return await _innerAsciify(startImg!, sensibility, chProcessor);
  }

  static Future<String> _innerAsciify(
      Image startImg, int sens, AsciiCharactersBrightness chProcessor) async {
    var imageLineList = <String>[];
    for (var yBlocK = 0; yBlocK < startImg.height; yBlocK = yBlocK + sens) {
      var lineList = <String>[];

      for (var xBlock = 0; xBlock < startImg.width; xBlock = xBlock + sens) {
        var sumBlockBright = 0.0;
        for (var y = 0; y < sens; y++) {
          for (var x = 0; x < sens; x++) {
            var pixel = startImg.getPixel(x + xBlock, y + yBlocK);
            var pixelBright = (getRed(pixel) * 0.299) +
                (getBlue(pixel) * 0.587) +
                (getGreen(pixel) * 0.114);
            sumBlockBright = sumBlockBright + pixelBright;
          }
        }
        var blockBright = sumBlockBright / (sens * sens);
        lineList.add(chProcessor.brightnessToChar(blockBright));
      }
      imageLineList.add(lineList.join(""));
    }

    var sb = StringBuffer();
    for (var line in imageLineList) {
      sb.write("$line\n");
    }
    return sb.toString();
  }
}
