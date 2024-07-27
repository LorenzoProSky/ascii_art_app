import 'dart:io';
import 'package:ascii_app/models/asciifier.dart';
import 'package:ascii_app/models/image_selector.dart';
import 'package:ascii_app/models/notifiers/image_path_cache.dart';
import 'package:ascii_app/routes/image_page/image_page_arguments.dart';
import 'package:ascii_app/widgets/back_button_custom.dart';
import 'package:ascii_app/widgets/basic/icon_button_custom.dart';
import 'package:ascii_app/widgets/basic/text_button_custom.dart';
import 'package:ascii_app/widgets/loading_overlay.dart';
import 'package:ascii_app/widgets/slider_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ImagePage extends StatefulWidget {
  final ImagePageArguments arguments; // NeedCamera
  const ImagePage(this.arguments, {super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool _isAscii = false; // There is an image ASCII
  String? _asciiImage; // Text ASCII Image
  double _pixelSensibility = 1.0;
  double _charSensibility = 1.0;

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
                  (screenHeight * 0.03 < 30) ? screenHeight * 0.03 : 30,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: (screenHeight * 0.03 < 30)
                              ? screenHeight * 0.03
                              : 30,
                        ),
                        // First row with back button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BackButtonCustom(
                              size: (screenHeight * 0.04 < 40)
                                  ? screenHeight * 0.04
                                  : 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: (screenHeight * 0.12 < 110)
                              ? screenHeight * 0.12
                              : 110,
                        ),
                        // Image area
                        _imageArea(
                          context,
                          (screenWidth < 500) ? screenWidth : 500,
                          (screenHeight * 0.62 < 420)
                              ? screenHeight * 0.62
                              : 420,
                        ),
                        SizedBox(
                          height: (screenHeight * 0.4 < 40)
                              ? screenHeight * 0.4
                              : 40,
                        ),
                        // ASCIIfy, Copy, Select Image buttons
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _asciifyButton(
                                context,
                                (screenWidth * 0.4 < 150)
                                    ? screenWidth * 0.4
                                    : 150,
                                (screenHeight * 0.05 < 50)
                                    ? screenHeight * 0.05
                                    : 50,
                              ),
                              SizedBox(
                                width: (screenWidth * 0.01 < 10)
                                    ? screenHeight * 0.01
                                    : 10,
                              ),
                              _copyButton(
                                context,
                                (screenHeight * 0.05 < 50)
                                    ? screenHeight * 0.05
                                    : 50,
                              ),
                              SizedBox(
                                width: (screenWidth * 0.005 < 5)
                                    ? screenHeight * 0.005
                                    : 5,
                              ),
                              _selectImageButton(
                                context,
                                (screenHeight * 0.05 < 50)
                                    ? screenHeight * 0.05
                                    : 50,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: (screenHeight * 0.025 < 25)
                              ? screenHeight * 0.025
                              : 25,
                        ),
                        // Sliders
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _sensibilitySlider(
                              context,
                              (screenWidth * 0.35 < 135)
                                  ? screenWidth * 0.35
                                  : 135,
                              (screenHeight * 0.045 < 45)
                                  ? screenHeight * 0.045
                                  : 45,
                            ),
                            SizedBox(
                              width: (screenWidth * 0.01 < 10)
                                  ? screenWidth * 0.01
                                  : 10,
                            ),
                            _charSlider(
                              context,
                              (screenWidth * 0.35 < 135)
                                  ? screenWidth * 0.35
                                  : 135,
                              (screenHeight * 0.045 < 45)
                                  ? screenHeight * 0.045
                                  : 45,
                            ),
                          ],
                        ),
                        _slidersText(
                          context,
                          screenWidth,
                          screenHeight,
                        ),
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

  // ---- Widgets ----

  // Image area: selected image or zoomable text ASCII image
  Widget _imageArea(BuildContext context, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: (_isAscii)
          ? FittedBox(
              fit: BoxFit.contain,
              child: InteractiveViewer(
                // Zoomable
                panEnabled: true,
                minScale: 1,
                maxScale: 50,
                child: Text(
                  _asciiImage!, // Text ASCII Image
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            )
          : (Provider.of<ImagePathCache>(context).imagePath != "")
              ? FittedBox(
                  fit: BoxFit.contain,
                  child: Image.file(
                    File(Provider.of<ImagePathCache>(context).imagePath),
                  ),
                )
              : Center(
                  // No image selected
                  child: Text(
                    "- Select an Image to ASCIIfy -",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
    );
  }

  // Asciify the image into an ASCII image text
  Widget _asciifyButton(BuildContext context, double width, double height) {
    // Capture instances before the async gap
    final imagePath =
        Provider.of<ImagePathCache>(context, listen: false).imagePath;
    final overlay = LoadingOverlay.of(context);
    
    return TextButtonCustom(
      buttonText: "ASCIIfy",
      width: width,
      height: height,
      onTap: () async {
        overlay.show();
        await Future.delayed(const Duration(milliseconds: 100));

        var temp = await Asciifier.asciify(
            imagePath, _pixelSensibility.toInt(), _charSensibility.toInt());
        _isAscii = true;

        await Future.delayed(const Duration(milliseconds: 100));
        overlay.hide();

        setState(() {
          _asciiImage = temp;
        });
      },
      isActive: (Provider.of<ImagePathCache>(context).imagePath != ""),
    );
  }

  // Select Image from the Camera or the Storage according to "needCamera"
  Widget _selectImageButton(BuildContext context, double size) {
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
            isActive: true,
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
            isActive: true,
          );
  }

  // Copy the ASCII image text to the clipboard
  Widget _copyButton(BuildContext context, double size) {
    return IconButtonCustom(
      iconData: Icons.copy,
      size: size,
      onTap: () {
        Clipboard.setData(ClipboardData(text: _asciiImage!));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SizedBox(
              height: size / 2,
              child: Text(
                'Copied to clipboard',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
              ),
            ),
            backgroundColor: Theme.of(context).focusColor,
            duration: const Duration(milliseconds: 1000),
          ),
        );
      },
      isActive: _isAscii,
    );
  }

  // Sliders for pixel sensibility
  Widget _sensibilitySlider(BuildContext context, double width, double height) {
    return SliderCustom(
      value: _pixelSensibility,
      onChange: (value) {
        setState(() {
          _pixelSensibility = value;
        });
      },
      min: 1.0,
      max: 20.0,
      divs: 19,
      width: width,
      height: height,
      isActive: (Provider.of<ImagePathCache>(context).imagePath != ""),
    );
  }

  // Sliders for char sensibility
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
      width: width,
      height: height,
      isActive: (Provider.of<ImagePathCache>(context).imagePath != ""),
    );
  }

  // Text under the sliders
  Widget _slidersText(BuildContext context, double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: (width * 0.5 < 50) ? width * 0.5 : 50,
          height: (height * 0.045 < 45) ? height * 0.045 : 45,
          child: Text(
            "Pixel",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        SizedBox(
          width: (width * 0.025 < 25) ? width * 0.025 : 25,
        ),
        SizedBox(
          width: (width * 0.5 < 100) ? width * 0.5 : 100,
          height: (height * 0.045 < 45) ? height * 0.045 : 45,
          child: Text(
            "Sensibility",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        SizedBox(
          width: (width * 0.025 < 25) ? width * 0.025 : 25,
        ),
        SizedBox(
          width: (width * 0.5 < 50) ? width * 0.5 : 50,
          height: (height * 0.045 < 45) ? height * 0.045 : 45,
          child: Text(
            "Char",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
