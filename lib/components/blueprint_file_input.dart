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
  final BlueprintButtonSize size;

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
    this.size = BlueprintButtonSize.medium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final displayText = hasSelection ? text : (text.isEmpty ? 'Choose file...' : text);
    final displayButtonText = buttonText ?? 'Browse';
    
    // Calculate button width and sizing based on Blueprint.js sizing
    double buttonWidth;
    double containerHeight;
    double horizontalPadding;
    double fontSize;
    double iconSize;
    
    if (large) {
      buttonWidth = BlueprintTheme.gridSize * 21.25; // $file-input-button-width-large
      containerHeight = BlueprintTheme.buttonHeightLarge;
      horizontalPadding = 12;
      fontSize = BlueprintTheme.fontSizeLarge;
      iconSize = 18;
    } else {
      buttonWidth = BlueprintTheme.gridSize * 17.5; // $file-input-button-width
      containerHeight = BlueprintTheme.buttonHeight;
      horizontalPadding = 10; // Slightly smaller for regular size
      fontSize = BlueprintTheme.fontSize; // Use regular font size
      iconSize = 16;
    }
    
    return Container(
      width: fill ? double.infinity : null,
      height: containerHeight,
      child: Stack(
        children: [
          // Input background (mimics Blueprint's .bp4-file-upload-input)
          Container(
            width: double.infinity,
            height: double.infinity,
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: buttonWidth + horizontalPadding, // Space for button
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        size: iconSize,
                        color: disabled
                            ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
                            : (hasSelection 
                                ? (isDark ? BlueprintColors.light1 : BlueprintColors.dark1)
                                : (isDark ? BlueprintColors.gray2 : BlueprintColors.gray3)),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: DefaultTextStyle(
                        style: TextStyle(
                          fontSize: fontSize,
                          color: disabled
                              ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
                              : (hasSelection 
                                  ? (isDark ? BlueprintColors.light1 : BlueprintColors.dark1)
                                  : (isDark ? BlueprintColors.gray2 : BlueprintColors.gray3)),
                          fontStyle: hasSelection ? FontStyle.normal : FontStyle.italic,
                          height: 1.0, // Critical for proper text centering
                        ),
                        child: Text(
                          displayText,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Button positioned absolutely (mimics Blueprint's ::after pseudo-element)
          Positioned(
            right: 2, // Small margin from edge
            top: 2,
            bottom: 2,
            child: Container(
              width: buttonWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: BlueprintButton(
                text: displayButtonText,
                intent: intent,
                disabled: disabled,
                size: large ? BlueprintButtonSize.large : BlueprintButtonSize.medium,
                onPressed: onPressed,
                variant: BlueprintButtonVariant.solid,
              ),
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