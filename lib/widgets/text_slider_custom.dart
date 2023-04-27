import 'package:ascii_app/theme/app_color.dart';
import 'package:flutter/material.dart';

class TextSliderCustom extends StatelessWidget {
  const TextSliderCustom({Key? key}) : super(key: key);

  static const TextStyle textSliderStyle = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.w300,
    fontSize: 18.0,
    color: AppColor.black,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Pixel',
          style: textSliderStyle,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Sensibility',
          style: textSliderStyle,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Character',
          style: textSliderStyle,
        ),
      ],
    );
  }
}
