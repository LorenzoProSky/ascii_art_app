import 'package:ascii_app/widgets/slider_track_shape_custom.dart';
import 'package:flutter/material.dart';

class SliderCustom extends StatelessWidget {
  const SliderCustom({
    Key? key,
    required this.value,
    required this.onChange,
    required this.min,
    required this.max,
    required this.divs,
    required this.width,
    required this.height,
    required this.isActive,
  }) : super(key: key);

  final double value;
  final Function(double) onChange;
  final double min;
  final double max;
  final int divs;
  final double width;
  final double height;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 5.0 * height / 22,
                trackShape: const RoundedRectSliderTrackShape(),
                activeTrackColor: Theme.of(context).focusColor,
                inactiveTrackColor: Theme.of(context).focusColor.withAlpha(100),
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 10.0 * height / 28,
                  pressedElevation: 8.0,
                ),
                thumbColor: Theme.of(context).focusColor,
                overlayColor: Theme.of(context).focusColor.withOpacity(0.2),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
                tickMarkShape: const RoundSliderTickMarkShape(),
                activeTickMarkColor: Theme.of(context).primaryColor,
                inactiveTickMarkColor: Theme.of(context).primaryColor,
                valueIndicatorShape: CircleWithTextThumbShape (
                  text: value.round().toString(),
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
              child: Slider(
                min: min,
                max: max,
                value: value,
                divisions: divs,
                label: '${value.round()}',
                onChanged: isActive ? onChange : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
