import 'dart:io';

import 'package:ascii_app/models/asciifier.dart';
import 'package:ascii_app/models/image_selector.dart';
import 'package:ascii_app/models/image_path_cache.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:provider/provider.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool isAscii = false;
  String? asciiImage;

  @override
  Widget build(BuildContext context) {
    var img = Provider.of<ImagePathCache>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 456,
              width: 580,
              child: (isAscii)
                  ? FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        // TODO Zoomable
                        asciiImage!,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    )
                  : FittedBox(child: Image.file(File(img.imagePath))),
            ),
            Column(
              children: [
                (isAscii)
                    ? OutlinedButton(
                        onPressed: () async {
                          await GallerySaver.saveImage(
                              context.read<ImagePathCache>().imagePath);
                        },
                        style: const ButtonStyle(
                          side: MaterialStatePropertyAll(BorderSide(width: 1)),
                          fixedSize:
                              MaterialStatePropertyAll(Size.fromWidth(200)),
                        ),
                        child: Text(
                          "Save Image",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      )
                    : OutlinedButton(
                        onPressed: asciiImageCreate,
                        style: const ButtonStyle(
                          side: MaterialStatePropertyAll(BorderSide(width: 1)),
                          fixedSize:
                              MaterialStatePropertyAll(Size.fromWidth(200)),
                        ),
                        child: Text(
                          "ASCIIfy",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                OutlinedButton(
                  onPressed: () async {
                    ImageSelector.selectImage(img);
                    isAscii = false;
                  },
                  style: const ButtonStyle(
                    side: MaterialStatePropertyAll(BorderSide(width: 1)),
                    fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)),
                  ),
                  child: Text(
                    "Select New Image",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void asciiImageCreate() {
    List<String> list;
    list = Asciifier.asciify(context.read<ImagePathCache>().imagePath);

    var sb = StringBuffer();
    for (var line in list) {
      sb.write("$line\n");
    }
    var temp = sb.toString();

    setState(() {
      asciiImage = temp;
      isAscii = true;
    });
  }
}
