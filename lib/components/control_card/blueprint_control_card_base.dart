import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import '../blueprint_card.dart';
import '../blueprint_switch.dart';
import '../blueprint_checkbox.dart';
import '../blueprint_radio.dart';
import '../blueprint_common.dart';

enum ControlCardType {
  checkbox,
  radio,
  switch_,
}

class BlueprintControlCard extends StatelessWidget {
  final ControlCardType type;
  final String? label;
  final String? description;
  final Widget? child;
  final bool value;
  final bool? groupValue;
  final ValueChanged<bool>? onChanged;
  final bool disabled;
  final bool showAsSelectedWhenChecked;
  final BlueprintElevation elevation;
  final bool compact;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const BlueprintControlCard({
    Key? key,
    required this.type,
    this.label,
    this.description,
    this.child,
    required this.value,
    this.groupValue,
    required this.onChanged,
    this.disabled = false,
    this.showAsSelectedWhenChecked = true,
    this.elevation = BlueprintElevation.zero,
    this.compact = false,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget control;
    
    switch (type) {
      case ControlCardType.checkbox:
        control = BlueprintCheckbox(
          checked: value,
          onChanged: disabled ? null : (val) => onChanged?.call(val ?? false),
        );
        break;
      case ControlCardType.radio:
        control = BlueprintRadio<bool>(
          value: value,
          groupValue: groupValue ?? false,
          onChanged: disabled ? null : (val) => onChanged?.call(val ?? false),
        );
        break;
      case ControlCardType.switch_:
        control = BlueprintSwitch(
          value: value,
          onChanged: disabled ? null : onChanged,
        );
        break;
    }

    Widget content = Row(
      children: [
        Expanded(
          child: child ?? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: TextStyle(
                    fontSize: BlueprintTheme.fontSize,
                    fontWeight: FontWeight.w500,
                    color: disabled 
                        ? BlueprintColors.textColorDisabled 
                        : BlueprintColors.textColor,
                  ),
                ),
              if (description != null) ...[
                const SizedBox(height: 2),
                Text(
                  description!,
                  style: TextStyle(
                    fontSize: BlueprintTheme.fontSizeSmall,
                    color: disabled 
                        ? BlueprintColors.textColorDisabled 
                        : BlueprintColors.textColorMuted,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: BlueprintTheme.gridSize),
        control,
      ],
    );

    return BlueprintCard(
      elevation: elevation,
      interactive: !disabled,
      selected: showAsSelectedWhenChecked && value,
      compact: compact,
      padding: padding,
      margin: margin,
      onTap: disabled ? null : () => onChanged?.call(!value),
      child: content,
    );
  }
}