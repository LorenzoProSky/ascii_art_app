import 'package:flutter/material.dart';

class IconButtonCustom extends StatelessWidget {
  const IconButtonCustom({
    Key? key,
    required this.iconData,
    required this.onTap,
    required this.size,
    required this.isActive,
  }) : super(key: key);
  final IconData iconData;
  final Function() onTap;
  final double size;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: Material(
          elevation: isActive ? 8.0 : 0.0,
          shadowColor: Theme.of(context).hintColor,
          borderRadius: BorderRadius.circular(size),
          child: InkWell(
            onTap: isActive ? onTap : null,
            borderRadius: BorderRadius.circular(size),
            child: Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: isActive ? Theme.of(context).focusColor : Theme.of(context).focusColor.withOpacity(0.5),
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
