import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import '../blueprint_common.dart';
import 'blueprint_slider_shapes.dart';

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
        valueIndicatorShape: const BlueprintSliderValueIndicatorShape(),
        trackHeight: 6,
        thumbShape: const BlueprintSliderThumbShape(),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
        rangeTickMarkShape: const RoundRangeSliderTickMarkShape(tickMarkRadius: 2),
        activeTickMarkColor: activeColor,
        inactiveTickMarkColor: inactiveColor,
        rangeThumbShape: const BlueprintRangeSliderThumbShape(),
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