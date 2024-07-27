import 'dart:ui';
import 'package:flutter/material.dart';

// Loading overlay widget: show a loading spinner on top of the widget below
class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({Key? key, required this.child}) : super(key: key);

  final Widget child; // To overlay on the widget below

  static LoadingOverlayState of(BuildContext context) {
    return context.findAncestorStateOfType<LoadingOverlayState>()!;
  }

  @override
  State<LoadingOverlay> createState() => LoadingOverlayState();
}

class LoadingOverlayState extends State<LoadingOverlay> {
  bool _isLoading = false;

  // Show the loading spinner
  void show() {
    setState(() {
      _isLoading = true;
    });
  }

  // Hide the loading spinner
  void hide() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child, // The widget below

        // Backdrop filter to blur the background
        if (_isLoading)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Opacity(
              opacity: 0.75,
              child: ModalBarrier(
                dismissible: false,
                color: Theme.of(context).hintColor,
              ),
            ),
          ),

        // Loading spinner
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Theme.of(context).focusColor,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
      ],
    );
  }
}
