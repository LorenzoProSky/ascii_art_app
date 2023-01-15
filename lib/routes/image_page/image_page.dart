// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ascii_app/models/asciifier.dart';
import 'package:ascii_app/models/image_path_cache.dart';
import 'package:ascii_app/models/image_selector.dart';
import 'package:ascii_app/routes/image_page/image_page_arguments.dart';
import 'package:ascii_app/widgets/custom_icon_button.dart';
import 'package:ascii_app/widgets/custom_text_button.dart';
import 'package:ascii_app/widgets/loading_overlay.dart';
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
              height: 15,
            ),
            Row(
              children: [
                _sensibilitySlider(context),
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
      height: 480,
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
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            )
          : (Provider.of<ImagePathCache>(context).imagePath != "")
              ? FittedBox(
                  child: Image.file(
                    File(Provider.of<ImagePathCache>(context).imagePath),
                  ),
                )
              : const FittedBox(), // TODO PlaceHolder Image (better than empty)
    );
  }

  // TODO Turn off Asciify button and sliders when no image
  Widget _asciifyButton(BuildContext context) {
    return CustomTextButton(
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
    // Select an Image from the Camera or the Storage according to "needCamera"
    return (widget.arguments.needCamera)
        ? CustomIconButton(
            iconData: Icons.camera_alt,
            onTap: () async {
              _isAscii = false;
              ImageSelector.selectImage(
                  Provider.of<ImagePathCache>(context, listen: false),
                  widget.arguments.needCamera);
            },
          )
        : CustomIconButton(
            iconData: Icons.photo,
            onTap: () async {
              _isAscii = false;
              ImageSelector.selectImage(
                  Provider.of<ImagePathCache>(context, listen: false),
                  widget.arguments.needCamera);
            },
          );
  }

  // TODO
  Widget _sensibilitySlider(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Slider(
        min: 1.0,
        max: 100.0,
        value: _pixelSensibility,
        divisions: 100,
        label: '${_pixelSensibility.round()}',
        onChanged: (value) {
          setState(() {
            _pixelSensibility = value;
          });
        },
      ),
    );
  }

  // TODO
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
