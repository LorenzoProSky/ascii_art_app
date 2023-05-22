// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ascii_app/models/asciifier.dart';
import 'package:ascii_app/models/image_selector.dart';
import 'package:ascii_app/models/notifiers/image_path_cache.dart';
import 'package:ascii_app/routes/image_page/image_page_arguments.dart';
import 'package:ascii_app/widgets/back_button_custom.dart';
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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          return Center(
            child: Container(
              width: screenWidth,
              height: screenHeight,
              color: Theme.of(context).canvasColor,
              child: Padding(
                padding: EdgeInsets.all(
                  (screenHeight * 0.045 < 30) ? screenHeight * 0.045 : 30,
                ),
                child: Column(
                  children: <Widget>[
                    _imageArea(
                        context,
                        (screenWidth * 0.8 < 580) ? screenWidth * 0.8 : 580,
                        (screenHeight * 0.68 < 460)
                            ? screenHeight * 0.68
                            : 460),
                    SizedBox(
                      height: (screenHeight * 0.035 < 20)
                          ? screenHeight * 0.035
                          : 20,
                    ),
                    Center(
                      child: SizedBox(
                        width:
                            (screenWidth * 0.6 < 235) ? screenWidth * 0.6 : 235,
                        height: (screenHeight * 0.05 < 50)
                            ? screenHeight * 0.05
                            : 50,
                        child: Row(
                          children: [
                            _asciifyButton(
                                context,
                                (screenWidth * 0.3 < 100)
                                    ? screenWidth * 0.3
                                    : 150,
                                (screenHeight * 0.05 < 50)
                                    ? screenHeight * 0.05
                                    : 50),
                            SizedBox(
                              width: (screenWidth * 0.025 < 10)
                                  ? screenHeight * 0.025
                                  : 10,
                            ),
                            _selectImageButton(
                                context,
                                (screenHeight * 0.05 < 50)
                                    ? screenHeight * 0.05
                                    : 50),
                            SizedBox(
                              width: (screenWidth * 0.025 < 10)
                                  ? screenHeight * 0.025
                                  : 10,
                            ),
                            BackButtonCustom(
                                size: (screenHeight * 0.05 < 50)
                                    ? screenHeight * 0.05
                                    : 50),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: (screenHeight * 0.035 < 20)
                          ? screenHeight * 0.035
                          : 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _sensibilitySlider(
                            context,
                            (screenWidth * 0.3 < 150) ? screenWidth * 0.3 : 150,
                            (screenHeight * 0.045 < 30)
                                ? screenHeight * 0.045
                                : 30),
                        SizedBox(
                          height: (screenHeight * 0.025 < 10)
                              ? screenHeight * 0.025
                              : 10,
                        ),
                        _charSlider(
                            context,
                            (screenWidth * 0.3 < 150) ? screenWidth * 0.3 : 150,
                            (screenHeight * 0.045 < 30)
                                ? screenHeight * 0.045
                                : 30),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _imageArea(BuildContext context, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
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
                  style: Theme.of(context).textTheme.displayLarge,
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

  Widget _asciifyButton(BuildContext context, double width, double height) {
    return TextButtonCustom(
      buttonText: "ASCIIfy",
      width: width,
      height: height,
      onTap: () async {
        LoadingOverlay.of(context).show();
        await Future.delayed(const Duration(milliseconds: 250));

        // Asciify the image into an ASCII image text
        var temp = await Asciifier.asciify(
            Provider.of<ImagePathCache>(context, listen: false).imagePath,
            _pixelSensibility.toInt(),
            _charSensibility.toInt());
        _isAscii = true;

        await Future.delayed(const Duration(milliseconds: 250));
        LoadingOverlay.of(context).hide();

        setState(() {
          _asciiImage = temp;
        });
      },
    );
  }

  Widget _selectImageButton(BuildContext context, double size) {
    // Select Image from the Camera or the Storage according to "needCamera"
    return (widget.arguments.needCamera)
        ? IconButtonCustom(
            iconData: Icons.camera_alt,
            size: size,
            onTap: () async {
              _isAscii = false;
              ImageSelector.selectImage(
                  Provider.of<ImagePathCache>(context, listen: false),
                  widget.arguments.needCamera);
            },
          )
        : IconButtonCustom(
            iconData: Icons.photo,
            size: size,
            onTap: () async {
              _isAscii = false;
              ImageSelector.selectImage(
                  Provider.of<ImagePathCache>(context, listen: false),
                  widget.arguments.needCamera);
            },
          );
  }

  Widget _sensibilitySlider(BuildContext context, double width, double height) {
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
      width: width,
      height: height,
    );
  }

  Widget _charSlider(BuildContext context, double width, double height) {
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
      width: width,
      height: height,
    );
  }
}
