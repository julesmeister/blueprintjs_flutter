import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';

enum BlueprintIntent {
  none,
  primary,
  success,
  warning,
  danger,
}

enum BlueprintButtonVariant {
  solid,
  minimal,
  outlined,
}

enum BlueprintButtonSize {
  small,
  medium,
  large,
}

class BlueprintButton extends StatefulWidget {
  final String? text;
  final Widget? child;
  final IconData? icon;
  final IconData? endIcon;
  final BlueprintIntent intent;
  final BlueprintButtonVariant variant;
  final BlueprintButtonSize size;
  final bool fill;
  final bool loading;
  final bool disabled;
  final VoidCallback? onPressed;

  const BlueprintButton({
    Key? key,
    this.text,
    this.child,
    this.icon,
    this.endIcon,
    this.intent = BlueprintIntent.none,
    this.variant = BlueprintButtonVariant.solid,
    this.size = BlueprintButtonSize.medium,
    this.fill = false,
    this.loading = false,
    this.disabled = false,
    this.onPressed,
  }) : super(key: key);

  @override
  State<BlueprintButton> createState() => _BlueprintButtonState();
}

class _BlueprintButtonState extends State<BlueprintButton> {
  bool _isHovered = false;

  double get _buttonHeight {
    switch (widget.size) {
      case BlueprintButtonSize.small:
        return BlueprintTheme.buttonHeightSmall;
      case BlueprintButtonSize.medium:
        return BlueprintTheme.buttonHeight;
      case BlueprintButtonSize.large:
        return BlueprintTheme.buttonHeightLarge;
    }
  }

  double get _iconSize {
    switch (widget.size) {
      case BlueprintButtonSize.small:
        return 14;
      case BlueprintButtonSize.medium:
        return 16;
      case BlueprintButtonSize.large:
        return 20;
    }
  }

  Color get _intentColor {
    switch (widget.intent) {
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

  Color get _backgroundColor {
    if (widget.disabled) {
      return widget.variant == BlueprintButtonVariant.minimal
          ? Colors.transparent
          : BlueprintColors.lightGray2;
    }

    switch (widget.variant) {
      case BlueprintButtonVariant.solid:
        if (widget.intent != BlueprintIntent.none) {
          return _intentColor;
        }
        return _isHovered ? BlueprintColors.lightGray2 : BlueprintColors.lightGray3;
      case BlueprintButtonVariant.minimal:
        return _isHovered ? BlueprintColors.lightGray2 : Colors.transparent;
      case BlueprintButtonVariant.outlined:
        return _isHovered ? BlueprintColors.lightGray2 : Colors.transparent;
    }
  }

  Color get _foregroundColor {
    if (widget.disabled) {
      return BlueprintColors.textColorDisabled;
    }

    switch (widget.variant) {
      case BlueprintButtonVariant.solid:
        if (widget.intent != BlueprintIntent.none) {
          return Colors.white;
        }
        return BlueprintColors.textColor;
      case BlueprintButtonVariant.minimal:
      case BlueprintButtonVariant.outlined:
        if (widget.intent != BlueprintIntent.none) {
          return _intentColor;
        }
        return BlueprintColors.textColor;
    }
  }

  BorderSide? get _borderSide {
    if (widget.variant == BlueprintButtonVariant.outlined) {
      return BorderSide(
        color: widget.disabled
            ? BlueprintColors.dividerBlackMuted
            : (widget.intent != BlueprintIntent.none ? _intentColor : BlueprintColors.gray3),
        width: 1,
      );
    }
    return null;
  }

  Widget _buildContent() {
    if (widget.loading) {
      return SizedBox(
        width: _iconSize,
        height: _iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_foregroundColor),
        ),
      );
    }

    final children = <Widget>[];
    
    if (widget.icon != null) {
      children.add(Icon(widget.icon, size: _iconSize, color: _foregroundColor));
      if (widget.text != null || widget.child != null) {
        children.add(const SizedBox(width: 6));
      }
    }
    
    if (widget.text != null || widget.child != null) {
      children.add(
        DefaultTextStyle(
          style: TextStyle(
            color: _foregroundColor,
            fontWeight: FontWeight.w500,
          ),
          child: widget.child ?? Text(widget.text!),
        ),
      );
    }
    
    if (widget.endIcon != null) {
      if (widget.text != null || widget.child != null) {
        children.add(const SizedBox(width: 6));
      }
      children.add(Icon(widget.endIcon, size: _iconSize, color: _foregroundColor));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.button,
      color: _backgroundColor,
      borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
      child: InkWell(
        onTap: widget.disabled || widget.loading ? null : widget.onPressed,
        onHover: (hovering) => setState(() => _isHovered = hovering),
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
        child: Container(
          constraints: BoxConstraints(
            minHeight: _buttonHeight,
            minWidth: widget.fill ? double.infinity : 0,
          ),
          width: widget.fill ? double.infinity : null,
          padding: EdgeInsets.symmetric(
            horizontal: BlueprintTheme.gridSize,
            vertical: BlueprintTheme.gridSize * 0.6,
          ),
          decoration: BoxDecoration(
            border: _borderSide != null ? Border.fromBorderSide(_borderSide!) : null,
            borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
          ),
          child: Center(
            child: _buildContent(),
          ),
        ),
      ),
    );
  }
}

// Helper factory methods
class BlueprintButtons {
  static Widget primary({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    IconData? endIcon,
    BlueprintButtonSize size = BlueprintButtonSize.medium,
    bool loading = false,
    bool disabled = false,
  }) {
    return BlueprintButton(
      key: key,
      text: text,
      intent: BlueprintIntent.primary,
      icon: icon,
      endIcon: endIcon,
      size: size,
      loading: loading,
      disabled: disabled,
      onPressed: onPressed,
    );
  }

  static Widget minimal({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    BlueprintIntent intent = BlueprintIntent.none,
    BlueprintButtonSize size = BlueprintButtonSize.medium,
  }) {
    return BlueprintButton(
      key: key,
      text: text,
      intent: intent,
      variant: BlueprintButtonVariant.minimal,
      icon: icon,
      size: size,
      onPressed: onPressed,
    );
  }

  static Widget outlined({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    BlueprintIntent intent = BlueprintIntent.none,
    BlueprintButtonSize size = BlueprintButtonSize.medium,
  }) {
    return BlueprintButton(
      key: key,
      text: text,
      intent: intent,
      variant: BlueprintButtonVariant.outlined,
      icon: icon,
      size: size,
      onPressed: onPressed,
    );
  }
}