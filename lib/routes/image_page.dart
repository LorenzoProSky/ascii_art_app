import 'dart:io';

import 'package:ascii_app/models/asciifier.dart';
import 'package:ascii_app/models/image_path_cache.dart';
import 'package:ascii_app/models/image_selector.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:provider/provider.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool _isAscii = false;
  String? _asciiImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          children: <Widget>[
            _imageArea(context),
            Column(
              children: [
                (_isAscii)
                    ? _saveImageButton(context)
                    : _asciifyButton(context),
                _selectImageButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageArea(BuildContext context) {
    return SizedBox(
      height: 456,
      width: 580,
      child: (_isAscii)
          ? FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                // TODO Zoomable
                _asciiImage!,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            )
          : FittedBox(
              child: Image.file(
                  File(Provider.of<ImagePathCache>(context).imagePath))),
    );
  }

  Widget _saveImageButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        await GallerySaver.saveImage(
            Provider.of<ImagePathCache>(context, listen: false).imagePath);
      },
      style: const ButtonStyle(
        side: MaterialStatePropertyAll(BorderSide(width: 1)),
        fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)),
      ),
      child: Text(
        "Save Image",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _asciifyButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        var temp = Asciifier.asciify(
            Provider.of<ImagePathCache>(context, listen: false).imagePath);
        _isAscii = true;
        setState(() {
          _asciiImage = temp;
        });
      },
      style: const ButtonStyle(
        side: MaterialStatePropertyAll(BorderSide(width: 1)),
        fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)),
      ),
      child: Text(
        "ASCIIfy",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _selectImageButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        ImageSelector.selectImage(
            Provider.of<ImagePathCache>(context, listen: false));
        _isAscii = false;
      },
      style: const ButtonStyle(
        side: MaterialStatePropertyAll(BorderSide(width: 1)),
        fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)),
      ),
      child: Text(
        "Select New Image",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
