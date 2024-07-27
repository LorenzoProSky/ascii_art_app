import 'dart:io';
import 'package:ascii_app/models/ascii_characters_brightness_tree_map.dart';
import 'package:image/image.dart';

// Asciifier class: Convert an image to ASCII art
class Asciifier {
  static Future<String> asciify(
      String path, int pixelSensibility, int charSensibility) async {
    // Min value of pixelSensibility = 1
    var startImg = decodeImage(File(path).readAsBytesSync()); // Read image from path
    var asciiMap = AsciiCharactersBrightnessTreeMap(charSensibility);

    return _innerAsciify(startImg!, pixelSensibility, asciiMap);
  }

  static Future<String> _innerAsciify(Image startImg, int sens,
      AsciiCharactersBrightnessTreeMap asciiMap) async {
    var imageLineList = <String>[];

    for (var yBlock = 0; yBlock < startImg.height; yBlock += sens) {
      var lineList = <String>[]; // Each String of the list is a pixel row

      for (var xBlock = 0; xBlock < startImg.width; xBlock += sens) {
        var sumBlockBright = 0.0;
        // Sum of th brightness of a block of pixels determined by "sens"
        for (var y = 0; y < sens; y++) {
          for (var x = 0; x < sens; x++) {
            try {
              var pixel = startImg.getPixel(x + xBlock, y + yBlock);
              // Brightness calculation based on perceived luminance of RGB color
              // https://www.w3.org/TR/AERT/#color-contrast
              var pixelBright =
                  (pixel.r * 0.299) + (pixel.b * 0.587) + (pixel.g * 0.114);
              sumBlockBright = sumBlockBright + pixelBright;
            } catch (e) {
              continue;
            }
          }
        }
        // Average brightness
        var blockBright = sumBlockBright / (sens * sens);
        lineList.add(asciiMap.brightnessToChar(blockBright)); // Add ch
      }
      imageLineList.add(lineList.join("")); // Add the pixel row to the image
    }

    var sb = StringBuffer();
    // Concat every String into one big String separated by new line
    for (var line in imageLineList) {
      sb.write("$line\n");
    }
    return sb.toString(); // Return the ASCII art
  }
}
