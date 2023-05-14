import 'package:flutter/material.dart';

class IconTextButtonCustom extends StatelessWidget {
  const IconTextButtonCustom({
    Key? key,
    required this.iconData,
    required this.buttonText,
    required this.onTap,
    required this.width,
  }) : super(key: key);
  final IconData iconData;
  final String buttonText;
  final Function() onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: width,
        child: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(50.0),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(50.0),
            child: Container(
              height: 50.0,
              width: width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Row(
                children: [
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).focusColor,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Icon(
                      iconData,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
