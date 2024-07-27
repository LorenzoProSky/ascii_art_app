import 'package:flutter/material.dart';

// Custom back button widget: pop the current screen
class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({
    Key? key,
    required this.size,
  }) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.5,
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        iconSize: size * 0.7,
        color: Theme.of(context).hintColor,
        highlightColor: Theme.of(context).focusColor,
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
