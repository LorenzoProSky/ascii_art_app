import 'package:flutter/material.dart';

class IconButtonCustom extends StatelessWidget {
  const IconButtonCustom({
    Key? key,
    required this.iconData,
    required this.onTap,
    required this.size,
  }) : super(key: key);
  final IconData iconData;
  final Function() onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(size),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(size),
            child: Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                borderRadius: BorderRadius.circular(size),
              ),
              child: Icon(
                iconData,
                size: size * 0.55,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
