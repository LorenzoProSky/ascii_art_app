import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({Key? key, required this.child}) : super(key: key);

  final Widget child; // Used to overlay on the widget below

  // ignore: library_private_types_in_public_api
  static _LoadingOverlayState of(BuildContext context) {
    return context.findAncestorStateOfType<_LoadingOverlayState>()!;
  }

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  bool _isLoading = false;

  void show() {
    setState(() {
      _isLoading = true;
    });
  }

  void hide() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
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
