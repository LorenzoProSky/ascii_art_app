import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitButtonCustom extends StatelessWidget {
  const ExitButtonCustom({
    Key? key,
    required this.size,
  }) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: IconButton(
        icon: const Icon(Icons.close_rounded),
        iconSize: size * 0.75,
        color: Theme.of(context).hintColor,
        highlightColor: Theme.of(context).focusColor,
        padding: EdgeInsets.zero,
        onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      ),
    );
  }
}