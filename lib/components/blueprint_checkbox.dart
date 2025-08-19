import 'blueprint_common.dart';

enum BlueprintCheckboxSize {
  regular,
  large,
}

class BlueprintCheckbox extends StatelessWidget {
  final bool? checked;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final Widget? child;
  final bool indeterminate;
  final bool disabled;
  final BlueprintIntent intent;
  final BlueprintCheckboxSize size;
  final bool inline;

  const BlueprintCheckbox({
    super.key,
    this.checked,
    this.onChanged,
    this.label,
    this.child,
    this.indeterminate = false,
    this.disabled = false,
    this.intent = BlueprintIntent.none,
    this.size = BlueprintCheckboxSize.regular,
    this.inline = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isChecked = checked ?? false;
    final effectiveIntent = intent != BlueprintIntent.none ? intent : BlueprintIntent.primary;
    
    final checkboxSize = size == BlueprintCheckboxSize.large ? 20.0 : 16.0;
    final fontSize = size == BlueprintCheckboxSize.large 
        ? BlueprintTheme.fontSizeLarge 
        : BlueprintTheme.fontSize;

    Color getCheckboxColor() {
      if (disabled) {
        return isDark ? BlueprintColors.gray1 : BlueprintColors.gray4;
      }
      
      if (isChecked || indeterminate) {
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
      
      if (isChecked || indeterminate) {
        return getCheckboxColor();
      }
      
      return isDark ? BlueprintColors.gray1 : BlueprintColors.gray3;
    }

    Widget buildCheckbox() {
      return GestureDetector(
        onTap: disabled ? null : () {
          if (indeterminate) {
            onChanged?.call(true);
          } else {
            onChanged?.call(!isChecked);
          }
        },
        child: Container(
          width: checkboxSize,
          height: checkboxSize,
          decoration: BoxDecoration(
            color: getCheckboxColor(),
            border: Border.all(
              color: getBorderColor(),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
          ),
          child: indeterminate
              ? Icon(
                  Icons.remove,
                  size: checkboxSize * 0.75,
                  color: Colors.white,
                )
              : isChecked
                  ? Icon(
                      Icons.check,
                      size: checkboxSize * 0.75,
                      color: Colors.white,
                    )
                  : null,
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
        onTap: disabled ? null : () {
          if (indeterminate) {
            onChanged?.call(true);
          } else {
            onChanged?.call(!isChecked);
          }
        },
        child: labelWidget,
      );
    }

    if (inline) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildCheckbox(),
          if (label != null || child != null) ...[
            const SizedBox(width: 8),
            buildLabel(),
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
            buildCheckbox(),
            if (label != null || child != null) ...[
              const SizedBox(width: 8),
              Expanded(child: buildLabel()),
            ],
          ],
        ),
      ],
    );
  }
}

class BlueprintCheckboxes {
  static BlueprintCheckbox simple({
    required String label,
    bool? checked,
    ValueChanged<bool?>? onChanged,
    bool disabled = false,
  }) {
    return BlueprintCheckbox(
      label: label,
      checked: checked,
      onChanged: onChanged,
      disabled: disabled,
    );
  }

  static BlueprintCheckbox withIntent({
    required String label,
    required BlueprintIntent intent,
    bool? checked,
    ValueChanged<bool?>? onChanged,
    bool disabled = false,
  }) {
    return BlueprintCheckbox(
      label: label,
      checked: checked,
      onChanged: onChanged,
      intent: intent,
      disabled: disabled,
    );
  }

  static BlueprintCheckbox indeterminate({
    required String label,
    ValueChanged<bool?>? onChanged,
    bool disabled = false,
  }) {
    return BlueprintCheckbox(
      label: label,
      checked: null,
      indeterminate: true,
      onChanged: onChanged,
      disabled: disabled,
    );
  }

  static BlueprintCheckbox large({
    required String label,
    bool? checked,
    ValueChanged<bool?>? onChanged,
    bool disabled = false,
  }) {
    return BlueprintCheckbox(
      label: label,
      checked: checked,
      onChanged: onChanged,
      size: BlueprintCheckboxSize.large,
      disabled: disabled,
    );
  }

  static BlueprintCheckbox inline({
    required String label,
    bool? checked,
    ValueChanged<bool?>? onChanged,
    bool disabled = false,
  }) {
    return BlueprintCheckbox(
      label: label,
      checked: checked,
      onChanged: onChanged,
      inline: true,
      disabled: disabled,
    );
  }
}