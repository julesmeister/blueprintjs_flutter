import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'blueprint_common.dart';

class BlueprintSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final bool disabled;
  final bool large;

  const BlueprintSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.disabled = false,
    this.large = false,
  });

  @override
  State<BlueprintSwitch> createState() => _BlueprintSwitchState();
}

class _BlueprintSwitchState extends State<BlueprintSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _indicatorAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _indicatorAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(BlueprintSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Exact Blueprint.js dimensions from SCSS:
    // $switch-width: 1.75em (28px at 16px font)
    // $control-indicator-size: 16px
    // $switch-indicator-margin: 2px
    // $switch-indicator-size: calc(1em - 4px) = 12px at 16px font
    const double switchWidth = 28.0; // 1.75em * 16px
    const double switchHeight = 16.0; // 1em * 16px  
    const double indicatorSize = 12.0; // calc(16px - 4px)
    const double indicatorMargin = 2.0;

    // Blueprint.js colors from SCSS
    Color getBackgroundColor() {
      if (widget.disabled) {
        return BlueprintColors.gray3.withValues(alpha: 0.15);
      }
      
      if (widget.value) {
        if (_isHovered) {
          return BlueprintColors.blue2; // hover color
        }
        return BlueprintColors.blue3; // checked background
      } else {
        if (_isHovered) {
          return BlueprintColors.gray3.withValues(alpha: 0.4); // hover color
        }
        return BlueprintColors.gray3.withValues(alpha: 0.3); // unchecked background
      }
    }

    Widget switchWidget = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.disabled ? null : () {
          widget.onChanged?.call(!widget.value);
        },
        onHover: (isHovered) {
          if (mounted) {
            setState(() => _isHovered = isHovered);
          }
        },
        borderRadius: BorderRadius.circular(switchWidth),
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          width: switchWidth,
          height: switchHeight,
          decoration: BoxDecoration(
            color: getBackgroundColor(),
            borderRadius: BorderRadius.circular(switchWidth), // full border-radius
          ),
          child: AnimatedBuilder(
            animation: _indicatorAnimation,
            builder: (context, child) {
              // Calculate exact position: left: calc(100% - 1em) when checked
              final maxOffset = switchWidth - indicatorSize - indicatorMargin * 2;
              final indicatorLeft = indicatorMargin + (_indicatorAnimation.value * maxOffset);
              
              return Stack(
                children: [
                  Positioned(
                    left: indicatorLeft,
                    top: indicatorMargin,
                    child: Container(
                      width: indicatorSize,
                      height: indicatorSize,
                      decoration: BoxDecoration(
                        color: widget.disabled
                            ? (widget.value 
                                ? Colors.white.withValues(alpha: 0.5)
                                : Colors.white.withValues(alpha: 0.8))
                            : Colors.white,
                        borderRadius: BorderRadius.circular(indicatorSize / 2),
                        boxShadow: widget.disabled ? [] : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            offset: const Offset(0, 0),
                            blurRadius: 0,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    if (widget.label != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          switchWidget,
          const SizedBox(width: 10), // $control-indicator-spacing
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              color: widget.disabled
                  ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
                  : (isDark ? BlueprintColors.light1 : BlueprintColors.dark1),
            ),
          ),
        ],
      );
    }

    return switchWidget;
  }
}

class BlueprintSwitches {
  static BlueprintSwitch simple({
    required bool value,
    ValueChanged<bool>? onChanged,
    bool disabled = false,
  }) {
    return BlueprintSwitch(
      value: value,
      onChanged: onChanged,
      disabled: disabled,
    );
  }

  static BlueprintSwitch withLabel({
    required bool value,
    required String label,
    ValueChanged<bool>? onChanged,
    bool disabled = false,
  }) {
    return BlueprintSwitch(
      value: value,
      label: label,
      onChanged: onChanged,
      disabled: disabled,
    );
  }

  static BlueprintSwitch large({
    required bool value,
    ValueChanged<bool>? onChanged,
    String? label,
    bool disabled = false,
  }) {
    return BlueprintSwitch(
      value: value,
      onChanged: onChanged,
      label: label,
      disabled: disabled,
      large: true,
    );
  }
}