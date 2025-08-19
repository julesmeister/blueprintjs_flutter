import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'blueprint_button.dart';
import 'blueprint_common.dart';

class BlueprintSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeEnd;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final BlueprintIntent intent;
  final bool disabled;
  final bool showLabels;
  final bool vertical;

  const BlueprintSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.intent = BlueprintIntent.primary,
    this.disabled = false,
    this.showLabels = true,
    this.vertical = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Color activeColor;
    switch (intent) {
      case BlueprintIntent.primary:
        activeColor = BlueprintColors.blue3;
        break;
      case BlueprintIntent.success:
        activeColor = BlueprintColors.green3;
        break;
      case BlueprintIntent.warning:
        activeColor = BlueprintColors.orange3;
        break;
      case BlueprintIntent.danger:
        activeColor = BlueprintColors.red3;
        break;
      case BlueprintIntent.none:
        activeColor = BlueprintColors.blue3;
        break;
    }

    final inactiveColor = isDark 
        ? const Color(0xFF30404D) 
        : const Color(0xFFCED9E0);
    final thumbColor = disabled 
        ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
        : activeColor;

    Widget slider = SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: disabled ? inactiveColor : activeColor,
        inactiveTrackColor: inactiveColor,
        thumbColor: thumbColor,
        overlayColor: activeColor.withValues(alpha: 0.1),
        valueIndicatorColor: activeColor,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
          fontSize: BlueprintTheme.fontSizeSmall,
        ),
        trackHeight: 6,
        thumbShape: const _BlueprintSliderThumbShape(),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
        tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 2),
        activeTickMarkColor: activeColor,
        inactiveTickMarkColor: inactiveColor,
      ),
      child: Slider(
        value: value,
        onChanged: disabled ? null : onChanged,
        onChangeEnd: onChangeEnd,
        min: min,
        max: max,
        divisions: divisions,
        label: label,
      ),
    );

    if (vertical) {
      slider = SizedBox(
        height: 200,
        child: RotatedBox(
          quarterTurns: 3,
          child: slider,
        ),
      );
    }

    if (!showLabels) {
      return slider;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        slider,
        if (showLabels) ...[
          const SizedBox(height: BlueprintTheme.gridSize * 0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                min.toStringAsFixed(divisions != null ? 1 : 0),
                style: TextStyle(
                  fontSize: BlueprintTheme.fontSizeSmall,
                  color: isDark ? BlueprintColors.gray1 : BlueprintColors.gray2,
                ),
              ),
              Text(
                max.toStringAsFixed(divisions != null ? 1 : 0),
                style: TextStyle(
                  fontSize: BlueprintTheme.fontSizeSmall,
                  color: isDark ? BlueprintColors.gray1 : BlueprintColors.gray2,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class BlueprintRangeSlider extends StatelessWidget {
  final RangeValues values;
  final ValueChanged<RangeValues>? onChanged;
  final ValueChanged<RangeValues>? onChangeEnd;
  final double min;
  final double max;
  final int? divisions;
  final RangeLabels? labels;
  final BlueprintIntent intent;
  final bool disabled;
  final bool showLabels;

  const BlueprintRangeSlider({
    super.key,
    required this.values,
    this.onChanged,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.labels,
    this.intent = BlueprintIntent.primary,
    this.disabled = false,
    this.showLabels = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Color activeColor;
    switch (intent) {
      case BlueprintIntent.primary:
        activeColor = BlueprintColors.blue3;
        break;
      case BlueprintIntent.success:
        activeColor = BlueprintColors.green3;
        break;
      case BlueprintIntent.warning:
        activeColor = BlueprintColors.orange3;
        break;
      case BlueprintIntent.danger:
        activeColor = BlueprintColors.red3;
        break;
      case BlueprintIntent.none:
        activeColor = BlueprintColors.blue3;
        break;
    }

    final inactiveColor = isDark 
        ? const Color(0xFF30404D) 
        : const Color(0xFFCED9E0);
    final thumbColor = disabled 
        ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
        : activeColor;

    Widget slider = SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: disabled ? inactiveColor : activeColor,
        inactiveTrackColor: inactiveColor,
        thumbColor: thumbColor,
        overlayColor: activeColor.withValues(alpha: 0.1),
        valueIndicatorColor: activeColor,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
          fontSize: BlueprintTheme.fontSizeSmall,
        ),
        trackHeight: 6,
        thumbShape: const _BlueprintSliderThumbShape(),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
        rangeTickMarkShape: const RoundRangeSliderTickMarkShape(tickMarkRadius: 2),
        activeTickMarkColor: activeColor,
        inactiveTickMarkColor: inactiveColor,
        rangeThumbShape: const _BlueprintRangeSliderThumbShape(),
      ),
      child: RangeSlider(
        values: values,
        onChanged: disabled ? null : onChanged,
        onChangeEnd: onChangeEnd,
        min: min,
        max: max,
        divisions: divisions,
        labels: labels,
      ),
    );

    if (!showLabels) {
      return slider;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        slider,
        if (showLabels) ...[
          const SizedBox(height: BlueprintTheme.gridSize * 0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                min.toStringAsFixed(divisions != null ? 1 : 0),
                style: TextStyle(
                  fontSize: BlueprintTheme.fontSizeSmall,
                  color: isDark ? BlueprintColors.gray1 : BlueprintColors.gray2,
                ),
              ),
              Text(
                max.toStringAsFixed(divisions != null ? 1 : 0),
                style: TextStyle(
                  fontSize: BlueprintTheme.fontSizeSmall,
                  color: isDark ? BlueprintColors.gray1 : BlueprintColors.gray2,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class BlueprintSliders {
  static BlueprintSlider simple({
    required double value,
    ValueChanged<double>? onChanged,
    double min = 0.0,
    double max = 100.0,
    int? divisions,
    bool showLabels = true,
  }) {
    return BlueprintSlider(
      value: value,
      onChanged: onChanged,
      min: min,
      max: max,
      divisions: divisions,
      showLabels: showLabels,
    );
  }

  static BlueprintSlider withIntent({
    required double value,
    required BlueprintIntent intent,
    ValueChanged<double>? onChanged,
    double min = 0.0,
    double max = 100.0,
    int? divisions,
    bool showLabels = true,
  }) {
    return BlueprintSlider(
      value: value,
      onChanged: onChanged,
      min: min,
      max: max,
      divisions: divisions,
      intent: intent,
      showLabels: showLabels,
    );
  }

  static BlueprintRangeSlider range({
    required RangeValues values,
    ValueChanged<RangeValues>? onChanged,
    double min = 0.0,
    double max = 100.0,
    int? divisions,
    bool showLabels = true,
  }) {
    return BlueprintRangeSlider(
      values: values,
      onChanged: onChanged,
      min: min,
      max: max,
      divisions: divisions,
      showLabels: showLabels,
    );
  }

  static BlueprintSlider vertical({
    required double value,
    ValueChanged<double>? onChanged,
    double min = 0.0,
    double max = 100.0,
    int? divisions,
    BlueprintIntent intent = BlueprintIntent.primary,
  }) {
    return BlueprintSlider(
      value: value,
      onChanged: onChanged,
      min: min,
      max: max,
      divisions: divisions,
      intent: intent,
      vertical: true,
      showLabels: false,
    );
  }
}

/// Custom slider thumb shape that matches Blueprint.js exactly
/// Blueprint uses 16px x 16px square thumbs with 2px border radius
class _BlueprintSliderThumbShape extends SliderComponentShape {
  const _BlueprintSliderThumbShape();

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

/// Custom range slider thumb shape that matches Blueprint.js
class _BlueprintRangeSliderThumbShape extends RangeSliderThumbShape {
  const _BlueprintRangeSliderThumbShape();

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