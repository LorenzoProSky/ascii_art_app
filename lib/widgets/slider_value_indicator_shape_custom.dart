import 'package:flutter/material.dart';

// Custom slider valueIndicatorShape
class CircleWithTextThumbShape extends SliderComponentShape {
  final double circleRadius;
  final String text;
  final TextStyle textStyle;

  CircleWithTextThumbShape({required this.text, required this.textStyle, required this.circleRadius});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.fromRadius(16.0);
  }

  // Paint the circle and text
  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    final circlePaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    // Draw the circle at the center
    canvas.drawCircle(center, circleRadius, circlePaint);

    // Draw the text at the center
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textAlign: TextAlign.center,
      textScaleFactor: textScaleFactor,
      textDirection: textDirection,
    );
    textPainter
      ..layout()
      ..paint(canvas,
          center - Offset(textPainter.width / 2, textPainter.height / 2));
  }
}
