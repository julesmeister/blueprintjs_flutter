import 'package:flutter/material.dart';
import 'dart:math' as math;

class BlueprintTooltipWithArrow extends StatefulWidget {
  final Widget child;
  final String content;
  final Color? backgroundColor;
  final Color? textColor;
  final bool compact;
  final bool disabled;

  const BlueprintTooltipWithArrow({
    super.key,
    required this.child,
    required this.content,
    this.backgroundColor,
    this.textColor,
    this.compact = false,
    this.disabled = false,
  });

  @override
  State<BlueprintTooltipWithArrow> createState() => _BlueprintTooltipWithArrowState();
}

class _BlueprintTooltipWithArrowState extends State<BlueprintTooltipWithArrow> {
  @override
  Widget build(BuildContext context) {
    if (widget.disabled) return widget.child;

    final backgroundColor = widget.backgroundColor ?? const Color(0xFF394B59);
    final textColor = widget.textColor ?? Colors.white;

    return TooltipTheme(
      data: TooltipThemeData(
        preferBelow: false,
        verticalOffset: 24,
      ),
      child: Tooltip(
        message: widget.content,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: TooltipShapeBorder(
            arrowWidth: 12,
            arrowHeight: 6,
            borderRadius: 3,
          ),
          shadows: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 0),
              blurRadius: 0,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              offset: const Offset(0, 8),
              blurRadius: 24,
            ),
          ],
        ),
        textStyle: TextStyle(
          color: textColor,
          fontSize: widget.compact ? 11 : 12,
          fontWeight: FontWeight.normal,
          height: 1.33, // Blueprint line height
        ),
        padding: EdgeInsets.symmetric(
          horizontal: widget.compact ? 7 : 12,
          vertical: widget.compact ? 5 : 10,
        ),
        waitDuration: const Duration(milliseconds: 100),
        showDuration: const Duration(seconds: 30),
        child: widget.child,
      ),
    );
  }
}

// Custom shape border for tooltip with arrow
class TooltipShapeBorder extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double borderRadius;

  const TooltipShapeBorder({
    this.arrowWidth = 12,
    this.arrowHeight = 6,
    this.borderRadius = 3,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: arrowHeight);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    
    // Adjust rect to account for arrow
    final tooltipRect = Rect.fromLTWH(
      rect.left,
      rect.top,
      rect.width,
      rect.height - arrowHeight,
    );

    // Create rounded rectangle for tooltip body
    final rrect = RRect.fromRectAndRadius(
      tooltipRect,
      Radius.circular(borderRadius),
    );
    path.addRRect(rrect);

    // Add arrow pointing down (tooltip above target)
    final arrowX = tooltipRect.center.dx;
    final arrowTop = tooltipRect.bottom;
    final arrowBottom = rect.bottom;

    path.moveTo(arrowX - arrowWidth / 2, arrowTop);
    path.lineTo(arrowX, arrowBottom);
    path.lineTo(arrowX + arrowWidth / 2, arrowTop);
    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // No additional painting needed - the decoration handles the fill
  }

  @override
  ShapeBorder scale(double t) {
    return TooltipShapeBorder(
      arrowWidth: arrowWidth * t,
      arrowHeight: arrowHeight * t,
      borderRadius: borderRadius * t,
    );
  }
}

// Factory methods
class BlueprintTooltipsWithArrow {
  static Widget simple({
    required Widget child,
    required String content,
    bool disabled = false,
  }) {
    return BlueprintTooltipWithArrow(
      content: content,
      disabled: disabled,
      child: child,
    );
  }

  static Widget intent({
    required Widget child,
    required String content,
    required intent,
    bool disabled = false,
  }) {
    Color backgroundColor;
    switch (intent.toString()) {
      case 'BlueprintIntent.primary':
        backgroundColor = const Color(0xFF2D72D2);
        break;
      case 'BlueprintIntent.success':
        backgroundColor = const Color(0xFF238551);
        break;
      case 'BlueprintIntent.warning':
        backgroundColor = const Color(0xFFC87619);
        break;
      case 'BlueprintIntent.danger':
        backgroundColor = const Color(0xFFCD4246);
        break;
      default:
        backgroundColor = const Color(0xFF394B59);
    }

    return BlueprintTooltipWithArrow(
      content: content,
      backgroundColor: backgroundColor,
      disabled: disabled,
      child: child,
    );
  }

  static Widget compact({
    required Widget child,
    required String content,
    bool disabled = false,
  }) {
    return BlueprintTooltipWithArrow(
      content: content,
      compact: true,
      disabled: disabled,
      child: child,
    );
  }
}