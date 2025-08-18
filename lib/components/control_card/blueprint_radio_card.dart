import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../blueprint_card.dart';
import 'blueprint_control_card_base.dart';

class BlueprintRadioCard extends StatelessWidget {
  final String? label;
  final String? description;
  final Widget? child;
  final bool value;
  final bool groupValue;
  final ValueChanged<bool>? onChanged;
  final bool disabled;
  final bool showAsSelectedWhenChecked;
  final BlueprintElevation elevation;
  final bool compact;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const BlueprintRadioCard({
    Key? key,
    this.label,
    this.description,
    this.child,
    required this.value,
    required this.groupValue,
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
    return BlueprintControlCard(
      type: ControlCardType.radio,
      label: label,
      description: description,
      child: child,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      disabled: disabled,
      showAsSelectedWhenChecked: showAsSelectedWhenChecked,
      elevation: elevation,
      compact: compact,
      padding: padding,
      margin: margin,
    );
  }
}