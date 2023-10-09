import 'package:flutter/material.dart';

class TextButtonCustom extends StatelessWidget {
  const TextButtonCustom({
    Key? key,
    required this.buttonText,
    required this.onTap,
    required this.width,
    required this.height,
    required this.isActive,
  }) : super(key: key);

  final String buttonText;
  final Function() onTap;
  final double width;
  final double height;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: Material(
          elevation: 8.0,
          shadowColor: Theme.of(context).hintColor,
          borderRadius: BorderRadius.circular(height),
          child: InkWell(
            onTap: isActive ? onTap : null,
            borderRadius: BorderRadius.circular(height),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(height),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        buttonText,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
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
