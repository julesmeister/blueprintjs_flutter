import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import 'tag_enums.dart';

class BlueprintCompoundTag extends StatelessWidget {
  final Widget leftContent;
  final Widget? rightContent;
  final IconData? icon;
  final IconData? rightIcon;
  final BlueprintIntent intent;
  final BlueprintTagSize size;
  final bool minimal;
  final bool round;
  final bool removable;
  final bool interactive;
  final bool fill;
  final bool active;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const BlueprintCompoundTag({
    super.key,
    required this.leftContent,
    this.rightContent,
    this.icon,
    this.rightIcon,
    this.intent = BlueprintIntent.none,
    this.size = BlueprintTagSize.medium,
    this.minimal = false,
    this.round = false,
    this.removable = false,
    this.interactive = false,
    this.fill = false,
    this.active = false,
    this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: interactive ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(round ? 50 : BlueprintTheme.borderRadius),
        ),
        child: Row(
          mainAxisSize: fill ? MainAxisSize.max : MainAxisSize.min,
          children: [
            // Left section
            Container(
              padding: _getPadding(),
              decoration: BoxDecoration(
                color: _getLeftBackgroundColor(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(round ? 50 : BlueprintTheme.borderRadius),
                  bottomLeft: Radius.circular(round ? 50 : BlueprintTheme.borderRadius),
                ),
                border: minimal ? Border.all(color: _getBorderColor(), width: 1) : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: _getIconSize(),
                      color: _getLeftTextColor(),
                    ),
                    SizedBox(width: _getSpacing() * 0.5),
                  ],
                  DefaultTextStyle(
                    style: TextStyle(
                      color: _getLeftTextColor(),
                      fontSize: _getFontSize(),
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                    ),
                    child: leftContent,
                  ),
                ],
              ),
            ),
            // Right section
            if (rightContent != null || rightIcon != null || removable)
              Container(
                padding: _getPadding(),
                decoration: BoxDecoration(
                  color: _getRightBackgroundColor(),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(round ? 50 : BlueprintTheme.borderRadius),
                    bottomRight: Radius.circular(round ? 50 : BlueprintTheme.borderRadius),
                  ),
                  border: minimal ? Border.all(color: _getBorderColor(), width: 1) : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (rightContent != null) ...[
                      Flexible(
                        child: DefaultTextStyle(
                          style: TextStyle(
                            color: _getRightTextColor(),
                            fontSize: _getFontSize(),
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                          ),
                          child: rightContent!,
                        ),
                      ),
                    ],
                    if (rightIcon != null) ...[
                      if (rightContent != null) SizedBox(width: _getSpacing() * 0.5),
                      Icon(
                        rightIcon,
                        size: _getIconSize(),
                        color: _getRightTextColor(),
                      ),
                    ],
                    if (removable) ...[
                      if (rightContent != null || rightIcon != null) SizedBox(width: _getSpacing() * 0.5),
                      GestureDetector(
                        onTap: onRemove,
                        child: Icon(
                          Icons.close,
                          size: _getIconSize(),
                          color: _getRightTextColor().withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
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

  Color _getLeftBackgroundColor() {
    if (minimal) {
      return Colors.transparent;
    }

    if (intent != BlueprintIntent.none) {
      // Left side uses darker shades but lighter than raw colors
      switch (intent) {
        case BlueprintIntent.primary:
          return BlueprintColors.blue3; // lighter than blue2
        case BlueprintIntent.success:
          return BlueprintColors.green3; // lighter than green2
        case BlueprintIntent.warning:
          return BlueprintColors.orange4; // keep orange4 as it's already reasonable
        case BlueprintIntent.danger:
          return BlueprintColors.red3; // lighter than red2
        case BlueprintIntent.none:
          break;
      }
    }

    return BlueprintColors.gray3; // much lighter than darkGray5
  }

  Color _getRightBackgroundColor() {
    if (minimal) {
      return Colors.transparent;
    }

    if (intent != BlueprintIntent.none) {
      // Right side uses lighter colors with some opacity
      switch (intent) {
        case BlueprintIntent.primary:
          return BlueprintColors.blue4.withValues(alpha: 0.3);
        case BlueprintIntent.success:
          return BlueprintColors.green4.withValues(alpha: 0.3);
        case BlueprintIntent.warning:
          return BlueprintColors.orange5.withValues(alpha: 0.3);
        case BlueprintIntent.danger:
          return BlueprintColors.red4.withValues(alpha: 0.3);
        case BlueprintIntent.none:
          break;
      }
    }

    return BlueprintColors.lightGray3; // much lighter than gray1
  }

  Color _getBorderColor() {
    if (intent != BlueprintIntent.none) {
      return _getIntentColor().withValues(alpha: 0.4);
    }
    return BlueprintColors.gray3.withValues(alpha: 0.4);
  }

  Color _getLeftTextColor() {
    if (minimal && intent != BlueprintIntent.none) {
      return _getIntentColor();
    }

    if (intent != BlueprintIntent.none) {
      // For lighter left backgrounds, we need better contrast
      switch (intent) {
        case BlueprintIntent.primary:
          return Colors.white; // blue3 background
        case BlueprintIntent.success:
          return Colors.white; // green3 background
        case BlueprintIntent.warning:
          return Colors.white; // orange4 background
        case BlueprintIntent.danger:
          return Colors.white; // red3 background
        case BlueprintIntent.none:
          break;
      }
    }

    return Colors.white; // gray3 background
  }

  Color _getRightTextColor() {
    if (minimal && intent != BlueprintIntent.none) {
      return _getIntentColor();
    }

    if (intent != BlueprintIntent.none) {
      // Right side has lighter backgrounds with opacity, so use dark text
      return BlueprintColors.textColor;
    }

    return BlueprintColors.textColor; // lightGray3 background
  }
}