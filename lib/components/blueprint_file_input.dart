import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'blueprint_button.dart';
import 'blueprint_common.dart';

class BlueprintFileInput extends StatelessWidget {
  final String text;
  final String? buttonText;
  final VoidCallback? onPressed;
  final bool disabled;
  final bool fill;
  final bool hasSelection;
  final BlueprintIntent intent;
  final IconData? icon;
  final bool large;

  const BlueprintFileInput({
    Key? key,
    this.text = 'Choose file...',
    this.buttonText,
    this.onPressed,
    this.disabled = false,
    this.fill = false,
    this.hasSelection = false,
    this.intent = BlueprintIntent.none,
    this.icon,
    this.large = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final displayText = hasSelection ? text : (text.isEmpty ? 'Choose file...' : text);
    final displayButtonText = buttonText ?? 'Browse';
    
    return Container(
      width: fill ? double.infinity : null,
      height: large ? BlueprintTheme.buttonHeightLarge : BlueprintTheme.buttonHeight,
      decoration: BoxDecoration(
        color: disabled
            ? (isDark ? BlueprintColors.dark2 : BlueprintColors.light4)
            : (isDark ? BlueprintColors.dark3 : BlueprintColors.light5),
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
        border: Border.all(
          color: isDark ? BlueprintColors.dark1 : BlueprintColors.gray5,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // File name/text area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: large ? 18 : 16,
                      color: disabled
                          ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
                          : (hasSelection 
                              ? (isDark ? BlueprintColors.light1 : BlueprintColors.dark1)
                              : (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      displayText,
                      style: TextStyle(
                        fontSize: large ? BlueprintTheme.fontSizeLarge : BlueprintTheme.fontSize,
                        color: disabled
                            ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
                            : (hasSelection 
                                ? (isDark ? BlueprintColors.light1 : BlueprintColors.dark1)
                                : (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)),
                        fontStyle: hasSelection ? FontStyle.normal : FontStyle.italic,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Browse button
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: isDark ? BlueprintColors.dark1 : BlueprintColors.gray5,
                  width: 1,
                ),
              ),
            ),
            child: BlueprintButton(
              text: displayButtonText,
              intent: intent,
              disabled: disabled,
              size: large ? BlueprintButtonSize.large : BlueprintButtonSize.medium,
              onPressed: onPressed,
              variant: BlueprintButtonVariant.minimal,
            ),
          ),
        ],
      ),
    );
  }
}

class BlueprintFileInputs {
  static BlueprintFileInput simple({
    String text = 'Choose file...',
    VoidCallback? onPressed,
    bool fill = false,
  }) {
    return BlueprintFileInput(
      text: text,
      onPressed: onPressed,
      fill: fill,
    );
  }

  static BlueprintFileInput withSelection({
    required String fileName,
    String buttonText = 'Browse',
    VoidCallback? onPressed,
    bool fill = false,
  }) {
    return BlueprintFileInput(
      text: fileName,
      buttonText: buttonText,
      onPressed: onPressed,
      hasSelection: true,
      fill: fill,
      icon: Icons.description,
    );
  }

  static BlueprintFileInput withIcon({
    required IconData icon,
    String text = 'Choose file...',
    VoidCallback? onPressed,
    bool fill = false,
  }) {
    return BlueprintFileInput(
      text: text,
      icon: icon,
      onPressed: onPressed,
      fill: fill,
    );
  }

  static BlueprintFileInput withIntent({
    required BlueprintIntent intent,
    String text = 'Choose file...',
    VoidCallback? onPressed,
    bool fill = false,
  }) {
    return BlueprintFileInput(
      text: text,
      intent: intent,
      onPressed: onPressed,
      fill: fill,
    );
  }

  static BlueprintFileInput large({
    String text = 'Choose file...',
    VoidCallback? onPressed,
    bool fill = false,
  }) {
    return BlueprintFileInput(
      text: text,
      onPressed: onPressed,
      fill: fill,
      large: true,
    );
  }
}