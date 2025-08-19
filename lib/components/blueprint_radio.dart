import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'blueprint_button.dart';
import 'blueprint_common.dart';

enum BlueprintRadioSize {
  regular,
  large,
}

class BlueprintRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final Widget? child;
  final bool disabled;
  final BlueprintIntent intent;
  final BlueprintRadioSize size;
  final bool inline;

  const BlueprintRadio({
    super.key,
    required this.value,
    this.groupValue,
    this.onChanged,
    this.label,
    this.child,
    this.disabled = false,
    this.intent = BlueprintIntent.none,
    this.size = BlueprintRadioSize.regular,
    this.inline = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = value == groupValue;
    final effectiveIntent = intent != BlueprintIntent.none ? intent : BlueprintIntent.primary;
    
    final radioSize = size == BlueprintRadioSize.large ? 20.0 : 16.0;
    final fontSize = size == BlueprintRadioSize.large 
        ? BlueprintTheme.fontSizeLarge 
        : BlueprintTheme.fontSize;

    Color getRadioColor() {
      if (disabled) {
        return isDark ? BlueprintColors.gray1 : BlueprintColors.gray4;
      }
      
      if (isSelected) {
        switch (effectiveIntent) {
          case BlueprintIntent.primary:
            return BlueprintColors.blue3;
          case BlueprintIntent.success:
            return BlueprintColors.green3;
          case BlueprintIntent.warning:
            return BlueprintColors.orange3;
          case BlueprintIntent.danger:
            return BlueprintColors.red3;
          case BlueprintIntent.none:
            return BlueprintColors.blue3;
        }
      }
      
      return Colors.transparent;
    }

    Color getBorderColor() {
      if (disabled) {
        return isDark ? BlueprintColors.gray1 : BlueprintColors.gray4;
      }
      
      if (isSelected) {
        return getRadioColor();
      }
      
      return isDark ? BlueprintColors.gray1 : BlueprintColors.gray3;
    }

    Widget buildRadio() {
      return GestureDetector(
        onTap: disabled ? null : () => onChanged?.call(value),
        child: Container(
          width: radioSize,
          height: radioSize,
          decoration: BoxDecoration(
            color: isDark ? BlueprintColors.dark3 : BlueprintColors.light5,
            border: Border.all(
              color: getBorderColor(),
              width: 1,
            ),
            shape: BoxShape.circle,
          ),
          child: isSelected ? Center(
            child: Container(
              width: radioSize * 0.5,
              height: radioSize * 0.5,
              decoration: BoxDecoration(
                color: getRadioColor(),
                shape: BoxShape.circle,
              ),
            ),
          ) : null,
        ),
      );
    }

    Widget buildLabel() {
      final labelText = label ?? '';
      final labelWidget = child ?? Text(
        labelText,
        style: TextStyle(
          fontSize: fontSize,
          color: disabled
              ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
              : (isDark ? BlueprintColors.light1 : BlueprintColors.dark1),
        ),
      );

      return GestureDetector(
        onTap: disabled ? null : () => onChanged?.call(value),
        child: labelWidget,
      );
    }

    if (inline) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildRadio(),
          if (label != null || child != null) ...[
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 2), // Same as checkbox for consistency
              child: buildLabel(),
            ),
          ],
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildRadio(),
            if (label != null || child != null) ...[
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2), // Same as checkbox for consistency
                  child: buildLabel(),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class BlueprintRadioGroup<T> extends StatelessWidget {
  final String? label;
  final List<BlueprintRadio<T>> options;
  final T? selectedValue;
  final ValueChanged<T?>? onChanged;
  final bool disabled;
  final bool inline;
  final MainAxisAlignment alignment;

  const BlueprintRadioGroup({
    super.key,
    this.label,
    required this.options,
    this.selectedValue,
    this.onChanged,
    this.disabled = false,
    this.inline = false,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final radioOptions = options.map((radio) {
      return BlueprintRadio<T>(
        value: radio.value,
        groupValue: selectedValue,
        onChanged: disabled ? null : onChanged,
        label: radio.label,
        child: radio.child,
        disabled: disabled || radio.disabled,
        intent: radio.intent,
        size: radio.size,
        inline: radio.inline,
      );
    }).toList();

    Widget buildOptions() {
      if (inline) {
        return Wrap(
          spacing: 16,
          children: radioOptions,
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: radioOptions
              .map((option) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: option,
                  ))
              .toList(),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w600,
              color: disabled
                  ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
                  : (isDark ? BlueprintColors.light1 : BlueprintColors.dark1),
            ),
          ),
          const SizedBox(height: 8),
        ],
        buildOptions(),
      ],
    );
  }
}

class BlueprintRadios {
  static BlueprintRadio<T> simple<T>({
    required T value,
    required String label,
    T? groupValue,
    ValueChanged<T?>? onChanged,
    bool disabled = false,
  }) {
    return BlueprintRadio<T>(
      value: value,
      label: label,
      groupValue: groupValue,
      onChanged: onChanged,
      disabled: disabled,
    );
  }

  static BlueprintRadio<T> withIntent<T>({
    required T value,
    required String label,
    required BlueprintIntent intent,
    T? groupValue,
    ValueChanged<T?>? onChanged,
    bool disabled = false,
  }) {
    return BlueprintRadio<T>(
      value: value,
      label: label,
      groupValue: groupValue,
      onChanged: onChanged,
      intent: intent,
      disabled: disabled,
    );
  }

  static BlueprintRadio<T> large<T>({
    required T value,
    required String label,
    T? groupValue,
    ValueChanged<T?>? onChanged,
    bool disabled = false,
  }) {
    return BlueprintRadio<T>(
      value: value,
      label: label,
      groupValue: groupValue,
      onChanged: onChanged,
      size: BlueprintRadioSize.large,
      disabled: disabled,
    );
  }

  static BlueprintRadio<T> inline<T>({
    required T value,
    required String label,
    T? groupValue,
    ValueChanged<T?>? onChanged,
    bool disabled = false,
  }) {
    return BlueprintRadio<T>(
      value: value,
      label: label,
      groupValue: groupValue,
      onChanged: onChanged,
      inline: true,
      disabled: disabled,
    );
  }

  static BlueprintRadioGroup<T> group<T>({
    String? label,
    required List<BlueprintRadio<T>> options,
    T? selectedValue,
    ValueChanged<T?>? onChanged,
    bool disabled = false,
    bool inline = false,
  }) {
    return BlueprintRadioGroup<T>(
      label: label,
      options: options,
      selectedValue: selectedValue,
      onChanged: onChanged,
      disabled: disabled,
      inline: inline,
    );
  }
}