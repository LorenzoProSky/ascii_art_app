import 'dart:io';
import 'package:image/image.dart';

class Asciifier {
  static String asciify(String path) {
    var startImg = decodeImage(File(path).readAsBytesSync());
    var sensblty = 1; // Min value 1

    var imageLineList = <String>[];
    for (var yBlocK = 0;
        yBlocK < startImg!.height;
        yBlocK = yBlocK + sensblty) {
      var lineList = <String>[];

      for (var xBlock = 0;
          xBlock < startImg.width;
          xBlock = xBlock + sensblty) {
        var sumBlockBright = 0.0;
        for (var y = 0; y < sensblty; y++) {
          for (var x = 0; x < sensblty; x++) {
            var pixel = startImg.getPixel(x + xBlock, y + yBlocK);
            var pixelBright = (getRed(pixel) * 0.299) +
                (getBlue(pixel) * 0.587) +
                (getGreen(pixel) * 0.114);
            sumBlockBright = sumBlockBright + pixelBright;
          }
        }
        var blockBright = sumBlockBright / (sensblty * sensblty);
        lineList.add(asciiChar(blockBright));
      }
      imageLineList.add(lineList.join(""));
    }

    var sb = StringBuffer();
    for (var line in imageLineList) {
      sb.write("$line\n");
    }
    var temp = sb.toString();

    return temp;
  }

  static String asciiChar(double p) {
    var str = " ";
    if (p >= 240) {
      str = " ";
    } else if (p >= 210) {
      str = ".";
    } else if (p >= 190) {
      str = "*";
    } else if (p >= 170) {
      str = "+";
    } else if (p >= 120) {
      str = "^";
    } else if (p >= 110) {
      str = "&";
    } else if (p >= 80) {
      str = "8";
    } else if (p >= 60) {
      str = "#";
    } else {
      str = "@";
    }
    return str;
  }
}
