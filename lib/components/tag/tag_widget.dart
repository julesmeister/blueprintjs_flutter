import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import 'tag_enums.dart';

class BlueprintTag extends StatelessWidget {
  final String text;
  final IconData? icon;
  final IconData? rightIcon;
  final BlueprintIntent intent;
  final BlueprintTagSize size;
  final bool minimal;
  final bool round;
  final bool removable;
  final bool interactive;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const BlueprintTag({
    super.key,
    required this.text,
    this.icon,
    this.rightIcon,
    this.intent = BlueprintIntent.none,
    this.size = BlueprintTagSize.medium,
    this.minimal = false,
    this.round = false,
    this.removable = false,
    this.interactive = false,
    this.backgroundColor,
    this.textColor,
    this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: interactive ? onTap : null,
      child: Container(
        padding: _getPadding(),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(round ? 50 : BlueprintTheme.borderRadius),
          border: minimal ? Border.all(color: _getBorderColor(), width: 1) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: _getIconSize(),
                color: _getTextColor(),
              ),
              SizedBox(width: _getSpacing() * 0.5),
            ],
            Text(
              text,
              style: TextStyle(
                color: _getTextColor(),
                fontSize: _getFontSize(),
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
            if (rightIcon != null) ...[
              SizedBox(width: _getSpacing() * 0.5),
              Icon(
                rightIcon,
                size: _getIconSize(),
                color: _getTextColor(),
              ),
            ],
            if (removable) ...[
              SizedBox(width: _getSpacing() * 0.5),
              GestureDetector(
                onTap: onRemove,
                child: Icon(
                  Icons.close,
                  size: _getIconSize(),
                  color: _getTextColor().withValues(alpha: 0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case BlueprintTagSize.small:
        return const EdgeInsets.symmetric(horizontal: 6, vertical: 2);
      case BlueprintTagSize.medium:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      case BlueprintTagSize.large:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 6);
    }
  }

  double _getFontSize() {
    switch (size) {
      case BlueprintTagSize.small:
        return BlueprintTheme.fontSizeSmall - 1;
      case BlueprintTagSize.medium:
        return BlueprintTheme.fontSizeSmall;
      case BlueprintTagSize.large:
        return BlueprintTheme.fontSize;
    }
  }

  double _getIconSize() {
    switch (size) {
      case BlueprintTagSize.small:
        return 10;
      case BlueprintTagSize.medium:
        return 12;
      case BlueprintTagSize.large:
        return 14;
    }
  }

  double _getSpacing() {
    switch (size) {
      case BlueprintTagSize.small:
        return 4;
      case BlueprintTagSize.medium:
        return 6;
      case BlueprintTagSize.large:
        return 8;
    }
  }

  Color _getIntentColor() {
    switch (intent) {
      case BlueprintIntent.primary:
        return BlueprintColors.intentPrimary;
      case BlueprintIntent.success:
        return BlueprintColors.intentSuccess;
      case BlueprintIntent.warning:
        return BlueprintColors.intentWarning;
      case BlueprintIntent.danger:
        return BlueprintColors.intentDanger;
      case BlueprintIntent.none:
        return BlueprintColors.gray3;
    }
  }

  Color _getBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;
    
    if (minimal) {
      return Colors.transparent;
    }

    if (intent != BlueprintIntent.none) {
      return _getIntentColor().withValues(alpha: 0.15);
    }

    return BlueprintColors.lightGray3;
  }

  Color _getBorderColor() {
    if (intent != BlueprintIntent.none) {
      return _getIntentColor().withValues(alpha: 0.4);
    }
    return BlueprintColors.gray3.withValues(alpha: 0.4);
  }

  Color _getTextColor() {
    if (textColor != null) return textColor!;
    
    if (minimal && intent != BlueprintIntent.none) {
      return _getIntentColor();
    }

    if (intent != BlueprintIntent.none) {
      // For filled intent tags, use darker color for better contrast
      switch (intent) {
        case BlueprintIntent.primary:
          return BlueprintColors.blue1;
        case BlueprintIntent.success:
          return BlueprintColors.green1;
        case BlueprintIntent.warning:
          return BlueprintColors.orange1;
        case BlueprintIntent.danger:
          return BlueprintColors.red1;
        case BlueprintIntent.none:
          break;
      }
    }

    return BlueprintColors.textColor;
  }
}