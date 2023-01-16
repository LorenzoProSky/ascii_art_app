// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ascii_app/models/asciifier.dart';
import 'package:ascii_app/models/image_path_cache.dart';
import 'package:ascii_app/models/image_selector.dart';
import 'package:ascii_app/routes/image_page/image_page_arguments.dart';
import 'package:ascii_app/widgets/icon_button_custom.dart';
import 'package:ascii_app/widgets/loading_overlay.dart';
import 'package:ascii_app/widgets/slider_custom.dart';
import 'package:ascii_app/widgets/text_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagePage extends StatefulWidget {
  final ImagePageArguments arguments; // NeedCamera
  const ImagePage(this.arguments, {super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool _isAscii = false; // Used to know if an image is ASCII or not
  String? _asciiImage; // Text ASCII Image
  double _pixelSensibility = 1;
  double _charSensibility = 1;

  @override
  void initState() {
    super.initState();
    ImageSelector.selectImage(
        Provider.of<ImagePathCache>(context, listen: false),
        widget.arguments.needCamera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(
          30.0,
        ),
        child: Column(
          children: <Widget>[
            _imageArea(context),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: 200,
                child: Row(
                  children: [
                    _asciifyButton(context),
                    const SizedBox(
                      width: 10,
                    ),
                    _selectImageButton(context),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _sensibilitySlider(context),
                const SizedBox(
                  width: 10,
                ),
                _charSlider(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageArea(BuildContext context) {
    return SizedBox(
      height: 460,
      width: 580,
      child: (_isAscii)
          ? FittedBox(
              fit: BoxFit.scaleDown,
              child: InteractiveViewer(
                // Zoomable
                panEnabled: true,
                minScale: 1,
                maxScale: 50,
                child: SelectableText(
                  _asciiImage!, // Text ASCII Image
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            )
          : (Provider.of<ImagePathCache>(context).imagePath != "")
              ? FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Image.file(
                    File(Provider.of<ImagePathCache>(context).imagePath),
                  ),
                )
              : const FittedBox(
                  // TODO PlaceHolder Image (better than empty)
                  ),
    );
  }

  // TODO Turn off Asciify button and sliders when no image
  Widget _asciifyButton(BuildContext context) {
    return TextButtonCustom(
      buttonText: "ASCIIfy",
      width: 140,
      onTap: () async {
        LoadingOverlay.of(context).show();
        await Future.delayed(const Duration(milliseconds: 250));

        // Asciify the image into an ASCII image text
        var temp = await Asciifier.asciify(
            Provider.of<ImagePathCache>(context, listen: false).imagePath,
            _pixelSensibility.toInt(),
            _charSensibility.toInt());
        _isAscii = true;

        await Future.delayed(const Duration(milliseconds: 100));
        LoadingOverlay.of(context).hide();

        setState(() {
          _asciiImage = temp;
        });
      },
    );
  }

  Widget _selectImageButton(BuildContext context) {
    // Select Image from the Camera or the Storage according to "needCamera"
    return (widget.arguments.needCamera)
        ? IconButtonCustom(
            iconData: Icons.camera_alt,
            onTap: () async {
              _isAscii = false;
              ImageSelector.selectImage(
                  Provider.of<ImagePathCache>(context, listen: false),
                  widget.arguments.needCamera);
            },
          )
        : IconButtonCustom(
            iconData: Icons.photo,
            onTap: () async {
              _isAscii = false;
              ImageSelector.selectImage(
                  Provider.of<ImagePathCache>(context, listen: false),
                  widget.arguments.needCamera);
            },
          );
  }

  Widget _sensibilitySlider(BuildContext context) {
    return SliderCustom(
      value: _pixelSensibility,
      onChange: (value) {
        setState(() {
          _pixelSensibility = value;
        });
      },
      min: 1.0,
      max: 100.0,
      divs: 100,
      text: "Pixel Sensibility",
      width: 150,
    );
  }

  Widget _charSlider(BuildContext context) {
    return SliderCustom(
      value: _charSensibility,
      onChange: (value) {
        setState(() {
          _charSensibility = value;
        });
      },
      min: 1.0,
      max: 3.0,
      divs: 2,
      text: "Char Sensibility",
      width: 150,
    );
  }
}
