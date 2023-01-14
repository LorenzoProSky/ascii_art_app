// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ascii_app/models/asciifier.dart';
import 'package:ascii_app/models/image_path_cache.dart';
import 'package:ascii_app/models/image_selector.dart';
import 'package:ascii_app/routes/image_page/image_page_arguments.dart';
import 'package:ascii_app/theme/theme.dart';
import 'package:ascii_app/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagePage extends StatefulWidget {
  final ImagePageArguments arguments;
  const ImagePage(this.arguments, {super.key});

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
                panEnabled: true,
                minScale: 1,
                maxScale: 50,
                child: SelectableText(
                  _asciiImage!,
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
              : const FittedBox(),
    );
  }

  Widget _asciifyButton(BuildContext context) {
    return Column(
      children: [
        // TODO Turn off Asciify button when no image
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
            LoadingOverlay.of(context).hide();

            setState(() {
              _asciiImage = temp;
            });
          },
          style: AppTheme.buttonStyle,
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
        _isAscii = false;
        ImageSelector.selectImage(
            Provider.of<ImagePathCache>(context, listen: false),
            widget.arguments.needCamera);
      },
      style: AppTheme.buttonStyle,
      child: Text(
        (widget.arguments.needCamera) ? "Take new Photo" : "Select New Image",
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
