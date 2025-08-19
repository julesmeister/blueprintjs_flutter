import 'package:flutter/material.dart';
import 'blueprint_common.dart';

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
  final bool loading;
  final bool disabled;
  final VoidCallback? onPressed;

  const BlueprintButton({
    super.key,
    this.text,
    this.child,
    this.icon,
    this.endIcon,
    this.intent = BlueprintIntent.none,
    this.variant = BlueprintButtonVariant.solid,
    this.size = BlueprintButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.onPressed,
  });

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

  double get _fontSize {
    switch (widget.size) {
      case BlueprintButtonSize.small:
        return BlueprintTheme.fontSizeSmall;
      case BlueprintButtonSize.medium:
        return BlueprintTheme.fontSize;
      case BlueprintButtonSize.large:
        return BlueprintTheme.fontSizeLarge;
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
          : BlueprintColors.lightGray1.withValues(alpha: 0.5);
    }

    switch (widget.variant) {
      case BlueprintButtonVariant.solid:
        if (widget.intent != BlueprintIntent.none) {
          // Handle all intent buttons with proper hover states
          switch (widget.intent) {
            case BlueprintIntent.primary:
              if (_isHovered) return BlueprintColors.blue2;
              return BlueprintColors.blue3;
            case BlueprintIntent.success:
              if (_isHovered) return BlueprintColors.green2;
              return BlueprintColors.green3;
            case BlueprintIntent.warning:
              // Special case - warning uses orange5 (light) with dark text
              if (_isHovered) return BlueprintColors.orange4;
              return BlueprintColors.orange5;
            case BlueprintIntent.danger:
              if (_isHovered) return BlueprintColors.red2;
              return BlueprintColors.red3;
            case BlueprintIntent.none:
              break;
          }
        }
        return _isHovered ? BlueprintColors.lightGray4 : BlueprintColors.lightGray5;
      case BlueprintButtonVariant.minimal:
        if (_isHovered) {
          return BlueprintColors.gray3.withValues(alpha: 0.15);
        }
        return Colors.transparent;
      case BlueprintButtonVariant.outlined:
        if (_isHovered) {
          return BlueprintColors.gray3.withValues(alpha: 0.15);
        }
        return Colors.transparent;
    }
  }

  Color get _foregroundColor {
    if (widget.disabled) {
      return BlueprintColors.textColorDisabled;
    }

    switch (widget.variant) {
      case BlueprintButtonVariant.solid:
        if (widget.intent != BlueprintIntent.none) {
          // Special case for warning - uses dark text instead of white
          if (widget.intent == BlueprintIntent.warning) {
            return BlueprintColors.textColor;
          }
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

  EdgeInsetsGeometry _getPadding() {
    switch (widget.size) {
      case BlueprintButtonSize.small:
        return EdgeInsets.symmetric(
          horizontal: BlueprintTheme.gridSize * 0.7,
          vertical: 0,
        );
      case BlueprintButtonSize.medium:
        return EdgeInsets.symmetric(
          horizontal: BlueprintTheme.gridSize,
          vertical: 0,
        );
      case BlueprintButtonSize.large:
        return EdgeInsets.symmetric(
          horizontal: BlueprintTheme.gridSize * 1.5,
          vertical: 0,
        );
    }
  }

  Border? get _border {
    if (widget.variant == BlueprintButtonVariant.minimal) {
      return null;
    }
    
    if (widget.disabled) {
      return null;
    }
    
    // For outlined buttons, we need a visible border
    if (widget.variant == BlueprintButtonVariant.outlined) {
      final borderColor = widget.intent != BlueprintIntent.none 
          ? _intentColor.withValues(alpha: 0.6) 
          : BlueprintColors.gray3.withValues(alpha: 0.4);
      return Border.all(color: borderColor, width: 1);
    }
    
    // For solid buttons, we use a subtle border
    return Border.all(
      color: Colors.black.withValues(alpha: 0.2), 
      width: 1,
    );
  }

  List<BoxShadow> get _boxShadow {
    if (widget.variant == BlueprintButtonVariant.minimal) {
      return [];
    }
    
    if (widget.disabled) {
      return [];
    }
    
    // Only solid buttons get a very subtle drop shadow
    if (widget.variant == BlueprintButtonVariant.solid) {
      return [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          offset: const Offset(0, 1),
          blurRadius: 1,
          spreadRadius: 0,
        ),
      ];
    }
    
    return [];
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
        Flexible(
          child: DefaultTextStyle(
            style: TextStyle(
              color: _foregroundColor,
              fontWeight: FontWeight.w400,
              fontSize: _fontSize,
              height: 1.0, // CRITICAL: Same fix as tags for perfect text centering
            ),
            child: widget.child ?? Text(
              widget.text!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: widget.disabled || widget.loading ? null : widget.onPressed,
        onHover: (hovering) => setState(() => _isHovered = hovering),
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
        child: Container(
          constraints: BoxConstraints(
            minHeight: _buttonHeight,
          ),
          padding: _getPadding(),
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
            border: _border,
            boxShadow: _boxShadow,
          ),
          child: _buildContent(),
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