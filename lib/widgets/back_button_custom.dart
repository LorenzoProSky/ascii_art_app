import 'package:flutter/material.dart';

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({
    Key? key,
    required this.size,
  }) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: size * 0.08,
        ),
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        iconSize: (size * 0.6 < 30) ? size * 0.6 : 30,
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
