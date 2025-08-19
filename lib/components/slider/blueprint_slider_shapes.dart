import 'package:flutter/material.dart';

/// Custom slider thumb shape that matches Blueprint.js exactly
/// Blueprint uses 16px x 16px square thumbs with 2px border radius
class BlueprintSliderThumbShape extends SliderComponentShape {
  const BlueprintSliderThumbShape();

  static const double _thumbSize = 16.0; // $pt-icon-size-standard = 16px
  static const double _thumbRadius = 8.0; // Half of thumb size
  static const double _borderRadius = 2.0; // $pt-border-radius = 2px

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.fromRadius(_thumbRadius);
  }

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
    final Canvas canvas = context.canvas;
    
    // Create the thumb rectangle (square with rounded corners)
    final Rect thumbRect = Rect.fromCenter(
      center: center,
      width: _thumbSize,
      height: _thumbSize,
    );
    
    final RRect thumbRRect = RRect.fromRectAndRadius(
      thumbRect,
      const Radius.circular(_borderRadius),
    );

    // Draw shadow first (Blueprint.js box-shadow: 0 1px 1px rgba(black, 0.5))
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0);
    
    final shadowRect = thumbRect.translate(0, 1);
    final shadowRRect = RRect.fromRectAndRadius(
      shadowRect,
      const Radius.circular(_borderRadius),
    );
    
    canvas.drawRRect(shadowRRect, shadowPaint);

    // Draw main thumb background
    final thumbPaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.white
      ..style = PaintingStyle.fill;
    
    canvas.drawRRect(thumbRRect, thumbPaint);

    // Draw border (Blueprint.js border-shadow: 0 0 0 1px rgba(black, 0.5))
    final borderPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    
    canvas.drawRRect(thumbRRect, borderPaint);
  }
}

/// Custom value indicator shape for rectangular tooltips like range slider
class BlueprintSliderValueIndicatorShape extends SliderComponentShape {
  const BlueprintSliderValueIndicatorShape();

  static const double _tooltipHeight = 28.0;
  static const double _tooltipRadius = 2.0;
  static const double _triangleHeight = 6.0;
  static const double _triangleWidth = 12.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.fromHeight(_tooltipHeight + _triangleHeight);
  }

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
    final Canvas canvas = context.canvas;
    final double scale = activationAnimation.value;

    if (scale == 0.0) return;

    // Calculate tooltip dimensions based on label text
    final double labelWidth = labelPainter.width + 16;
    final double labelHeight = _tooltipHeight;

    // Position tooltip above the thumb
    final double tooltipCenterX = center.dx;
    final double tooltipCenterY = center.dy - (_tooltipHeight / 2) - _triangleHeight - 8;

    // Create rectangular tooltip path (like range slider)
    final Rect tooltipRect = Rect.fromCenter(
      center: Offset(tooltipCenterX, tooltipCenterY),
      width: labelWidth,
      height: labelHeight,
    );

    final RRect tooltipRRect = RRect.fromRectAndRadius(
      tooltipRect,
      const Radius.circular(_tooltipRadius),
    );

    // Create triangle pointer path
    final Path trianglePath = Path();
    trianglePath.moveTo(tooltipCenterX - _triangleWidth / 2, tooltipCenterY + labelHeight / 2);
    trianglePath.lineTo(tooltipCenterX, tooltipCenterY + labelHeight / 2 + _triangleHeight);
    trianglePath.lineTo(tooltipCenterX + _triangleWidth / 2, tooltipCenterY + labelHeight / 2);
    trianglePath.close();

    // Draw tooltip background
    final Paint tooltipPaint = Paint()
      ..color = sliderTheme.valueIndicatorColor ?? Colors.grey.shade800
      ..style = PaintingStyle.fill;

    canvas.drawRRect(tooltipRRect, tooltipPaint);
    canvas.drawPath(trianglePath, tooltipPaint);

    // Draw the label text
    final Offset labelOffset = Offset(
      tooltipCenterX - labelPainter.width / 2,
      tooltipCenterY - labelPainter.height / 2,
    );

    canvas.save();
    canvas.scale(scale, scale);
    canvas.translate(
      labelOffset.dx * (1 - scale) / scale,
      labelOffset.dy * (1 - scale) / scale,
    );
    labelPainter.paint(canvas, labelOffset / scale);
    canvas.restore();
  }
}

/// Custom range slider thumb shape that matches Blueprint.js
class BlueprintRangeSliderThumbShape extends RangeSliderThumbShape {
  const BlueprintRangeSliderThumbShape();

  static const double _thumbSize = 16.0; // $pt-icon-size-standard = 16px
  static const double _thumbRadius = 8.0; // Half of thumb size
  static const double _borderRadius = 2.0; // $pt-border-radius = 2px

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.fromRadius(_thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = true,
    bool isOnTop = false,
    bool isPressed = false,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
  }) {
    final Canvas canvas = context.canvas;
    
    // Create the thumb rectangle (square with rounded corners)
    final Rect thumbRect = Rect.fromCenter(
      center: center,
      width: _thumbSize,
      height: _thumbSize,
    );
    
    final RRect thumbRRect = RRect.fromRectAndRadius(
      thumbRect,
      const Radius.circular(_borderRadius),
    );

    // Draw shadow first (Blueprint.js box-shadow: 0 1px 1px rgba(black, 0.5))
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0);
    
    final shadowRect = thumbRect.translate(0, 1);
    final shadowRRect = RRect.fromRectAndRadius(
      shadowRect,
      const Radius.circular(_borderRadius),
    );
    
    canvas.drawRRect(shadowRRect, shadowPaint);

    // Draw main thumb background
    final thumbPaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.white
      ..style = PaintingStyle.fill;
    
    canvas.drawRRect(thumbRRect, thumbPaint);

    // Draw border (Blueprint.js border-shadow: 0 0 0 1px rgba(black, 0.5))
    final borderPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    
    canvas.drawRRect(thumbRRect, borderPaint);
  }
}