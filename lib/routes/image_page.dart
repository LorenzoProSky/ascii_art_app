// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ascii_app/models/asciifier.dart';
import 'package:ascii_app/models/image_path_cache.dart';
import 'package:ascii_app/models/image_selector.dart';
import 'package:ascii_app/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool _isAscii = false;
  String? _asciiImage;
  double _sensibility = 1;
  double _charSensibility = 1;

  @override
  void initState() {
    super.initState();
    ImageSelector.selectImage(
        Provider.of<ImagePathCache>(context, listen: false));
  }

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
                _asciifyButton(context),
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
              child: InteractiveViewer(
                panEnabled: true, // Set it to false to prevent panning.
                minScale: 1,
                maxScale: 50,
                child: SelectableText(
                  _asciiImage!,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            )
          : (Provider.of<ImagePathCache>(context).imagePath !=
                  "assets/inv_pixel.png")
              ? FittedBox(
                  child: Image.file(
                    File(Provider.of<ImagePathCache>(context).imagePath),
                  ),
                )
              : const FittedBox(
                  child: Image(
                    image: AssetImage("assets/inv_pixel.png"),
                  ),
                ),
    );
  }

  Widget _asciifyButton(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () async {
            LoadingOverlay.of(context).show();
            await Future.delayed(const Duration(milliseconds: 400));
            var temp = await Asciifier.asciify(
                Provider.of<ImagePathCache>(context, listen: false).imagePath,
                _sensibility.toInt(),
                _charSensibility.toInt());
            _isAscii = true;
            await Future.delayed(const Duration(milliseconds: 100));
            setState(() {
              _asciiImage = temp;
            });
            LoadingOverlay.of(context).hide();
          },
          style: const ButtonStyle(
            side: MaterialStatePropertyAll(BorderSide(width: 1)),
            fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)),
          ),
          child: Text(
            "ASCIIfy",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Row(
          children: [
            _sensibilitySlider(context),
            _charSlider(context),
          ],
        )
      ],
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

  Widget _sensibilitySlider(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Slider(
        min: 1.0,
        max: 100.0,
        // TODO Max value can't be bigger than the image size
        value: _sensibility,
        divisions: 100,
        label: '${_sensibility.round()}',
        onChanged: (value) {
          setState(() {
            _sensibility = value;
          });
        },
      ),
    );
  }

  Widget _charSlider(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Slider(
        min: 1.0,
        max: 3.0,
        value: _charSensibility,
        divisions: 2,
        label: '${_charSensibility.round()}',
        onChanged: (value) {
          setState(() {
            _charSensibility = value;
          });
        },
      ),
    );
  }
}
