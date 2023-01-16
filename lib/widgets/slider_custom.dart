import 'package:ascii_app/theme/app_color.dart';
import 'package:flutter/material.dart';

class SliderCustom extends StatelessWidget {
  const SliderCustom({
    Key? key,
    required this.value,
    required this.onChange,
    required this.min,
    required this.max,
    required this.divs,
    required this.text,
    required this.width,
  }) : super(key: key);
  final double value;
  final Function(double) onChange;
  final double min;
  final double max;
  final int divs;
  final String text;
  final double width;

  // TODO Label inside the circle not above
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 30,
            width: width,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 5.0,
                trackShape: const RoundedRectSliderTrackShape(),
                activeTrackColor: Theme.of(context).focusColor,
                inactiveTrackColor:
                    Theme.of(context).focusColor.withAlpha(100),
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 10.0,
                  pressedElevation: 8.0,
                ),
                thumbColor: Theme.of(context).primaryColor,
                overlayColor:
                    Theme.of(context).focusColor.withOpacity(0.2),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
                tickMarkShape: const RoundSliderTickMarkShape(),
                activeTickMarkColor: Theme.of(context).primaryColor,
                inactiveTickMarkColor: Theme.of(context).primaryColor,
                valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Theme.of(context).primaryColor,
                valueIndicatorTextStyle: Theme.of(context).textTheme.bodyText1,
              ),
              child: Slider(
                min: min,
                max: max,
                value: value,
                divisions: divs,
                label: '${value.round()}',
                onChanged: onChange,
              ),
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
