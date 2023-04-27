import 'dart:io';

import 'package:ascii_app/models/ascii_characters_brightness_tree_map.dart';
import 'package:image/image.dart';

class Asciifier {
  static Future<String> asciify(
      String path, int pixelSensibility, int charSensibility) async {
    // Min value of pixelSensibility = 1
    var startImg = decodeImage(File(path).readAsBytesSync());
    var chProcessor = AsciiCharactersBrightnessTreeMap(charSensibility);

    return _innerAsciify(startImg!, pixelSensibility, chProcessor);
  }

  static Future<String> _innerAsciify(Image startImg, int sens,
      AsciiCharactersBrightnessTreeMap chProcessor) async {
    var imageLineList = <String>[];

    for (var yBlocK = 0; yBlocK < startImg.height; yBlocK = yBlocK + sens) {
      var lineList = <String>[]; // Each String of the list is a pixel row

      for (var xBlock = 0; xBlock < startImg.width; xBlock = xBlock + sens) {
        var sumBlockBright = 0.0;
        var tempPixelBright = 0.0;
        // Sum of th brightness of a block of pixels determined by "sens"
        for (var y = 0; y < sens; y++) {
          for (var x = 0; x < sens; x++) {
            try {
              var pixel = startImg.getPixel(x + xBlock, y + yBlocK);
              var pixelBright = (getRed(pixel) * 0.299) +
                  (getBlue(pixel) * 0.587) +
                  (getGreen(pixel) * 0.114);
              tempPixelBright = pixelBright;
              sumBlockBright = sumBlockBright + pixelBright;
            } catch (e) {
              sumBlockBright = sumBlockBright + tempPixelBright;
              continue;
            }
          }
        }
        // Average brightness
        var blockBright = sumBlockBright / (sens * sens);
        lineList.add(chProcessor.brightnessToChar(blockBright)); // Add ch
      }
      imageLineList.add(lineList.join("")); // Add the pixel row to the image
    }

    var sb = StringBuffer();
    // Concat every String into one big String separated by new line
    for (var line in imageLineList) {
      sb.write("$line\n");
    }
    return sb.toString();
  }
}
