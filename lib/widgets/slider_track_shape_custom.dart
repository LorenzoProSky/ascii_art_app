import 'package:flutter/material.dart';

class CircleWithTextThumbShape extends SliderComponentShape {
  final String text;
  final TextStyle textStyle;

  CircleWithTextThumbShape(
      {this.text = '',
      this.textStyle = const TextStyle(fontSize: 12.0, color: Colors.white)});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.fromRadius(20.0); // Adjust based on your requirements
  }

  @override
  void paint(
    PaintingContext context,
    Offset center,
    {
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
    canvas.drawCircle(center, 16.0, circlePaint); // Adjust radius as needed

    // Calculate text size and position
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
