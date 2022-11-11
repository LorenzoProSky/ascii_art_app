import 'dart:typed_data';

import 'package:ascii_app/utilities/asciifier.dart';
import 'package:ascii_app/utilities/img_cache.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  Uint8List? image;
  String? path;
  bool isAscii = false;
  String? asciiImage;

  @override
  Widget build(BuildContext context) {
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
                        asciiImage!,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    )
                  : FittedBox(
                      child: (image == null)
                          ? Image.memory(context.read<ImgCache>().imgCache)
                          : Image.memory(image!),
                    ),
            ),
            Column(
              children: [
                (isAscii)
                    ? OutlinedButton(
                        onPressed: () async {
                          (path == null)
                              ? await GallerySaver.saveImage(
                                  context.read<ImgCache>().imgPath)
                              : await GallerySaver.saveImage(path!);
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
                  onPressed: selectImage,
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

  void selectImage() async {
    final picker = ImagePicker();
    final selectedFile = await picker.pickImage(source: ImageSource.gallery);

    final imgPath = selectedFile!.path;
    final bytes = await selectedFile.readAsBytes();
    setState(() {
      image = bytes;
      path = imgPath;
      isAscii = false;
    });
  }

  void asciiImageCreate() {
    List<String> list;
    if (path == null) {
      list = Asciifier.asciify(context.read<ImgCache>().imgPath);
    } else {
      list = Asciifier.asciify(path!);
    }

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
