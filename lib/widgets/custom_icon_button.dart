import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);
  final IconData iconData;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(50.0),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(50.0),
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Icon(
                iconData,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
