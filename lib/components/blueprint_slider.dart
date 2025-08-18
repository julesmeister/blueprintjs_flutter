import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'blueprint_button.dart';

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
    Key? key,
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
  }) : super(key: key);

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

    final inactiveColor = isDark ? BlueprintColors.gray1 : BlueprintColors.gray4;
    final thumbColor = disabled 
        ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
        : activeColor;

    Widget slider = SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: disabled ? inactiveColor : activeColor,
        inactiveTrackColor: inactiveColor,
        thumbColor: thumbColor,
        overlayColor: activeColor.withOpacity(0.1),
        valueIndicatorColor: activeColor,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
          fontSize: BlueprintTheme.fontSizeSmall,
        ),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
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
    Key? key,
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
  }) : super(key: key);

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

    final inactiveColor = isDark ? BlueprintColors.gray1 : BlueprintColors.gray4;
    final thumbColor = disabled 
        ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
        : activeColor;

    Widget slider = SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: disabled ? inactiveColor : activeColor,
        inactiveTrackColor: inactiveColor,
        thumbColor: thumbColor,
        overlayColor: activeColor.withOpacity(0.1),
        valueIndicatorColor: activeColor,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
          fontSize: BlueprintTheme.fontSizeSmall,
        ),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
        rangeTickMarkShape: const RoundRangeSliderTickMarkShape(tickMarkRadius: 2),
        activeTickMarkColor: activeColor,
        inactiveTickMarkColor: inactiveColor,
        rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 8),
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