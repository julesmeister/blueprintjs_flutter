import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'popover_models.dart';
import 'popover_positioning.dart';

class PopoverContent extends StatelessWidget {
  final Widget content;
  final BlueprintPopoverPosition position;
  final bool minimal;
  final Offset targetOffset;
  final Size targetSize;
  final Size screenSize;
  final double? maxWidth;
  final double? maxHeight;
  final Animation<double> scaleAnimation;
  final Animation<double> fadeAnimation;
  final Function(bool) onPopoverHover;

  const PopoverContent({
    super.key,
    required this.content,
    required this.position,
    required this.minimal,
    required this.targetOffset,
    required this.targetSize,
    required this.screenSize,
    this.maxWidth,
    this.maxHeight,
    required this.scaleAnimation,
    required this.fadeAnimation,
    required this.onPopoverHover,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: PopoverPositionDelegate(
        targetOffset: targetOffset,
        targetSize: targetSize,
        position: position,
        screenSize: screenSize,
        minimal: minimal,
      ),
      child: FadeTransition(
        opacity: fadeAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          alignment: _getScaleAlignment(),
          child: MouseRegion(
            onEnter: (_) => onPopoverHover(true),
            onExit: (_) => onPopoverHover(false),
            child: _buildPopoverContent(),
          ),
        ),
      ),
    );
  }

  Alignment _getScaleAlignment() {
    switch (position) {
      case BlueprintPopoverPosition.top:
      case BlueprintPopoverPosition.topLeft:
      case BlueprintPopoverPosition.topRight:
        return Alignment.bottomCenter;
      case BlueprintPopoverPosition.bottom:
      case BlueprintPopoverPosition.bottomLeft:
      case BlueprintPopoverPosition.bottomRight:
        return Alignment.topCenter;
      case BlueprintPopoverPosition.left:
        return Alignment.centerRight;
      case BlueprintPopoverPosition.right:
        return Alignment.centerLeft;
    }
  }

  Widget _buildPopoverContent() {
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? 300,
          maxHeight: maxHeight ?? 400,
        ),
        padding: const EdgeInsets.all(BlueprintTheme.gridSize),
        decoration: ShapeDecoration(
          color: minimal ? BlueprintColors.lightGray5 : Colors.white,
          shape: PopoverShapeBorder(
            position: position,
            arrowWidth: minimal ? 0 : 12,
            arrowHeight: minimal ? 0 : 6,
            borderRadius: BlueprintTheme.borderRadius,
          ),
          shadows: minimal ? [
            // Minimal shadow for minimal popovers
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ] : [
            // Blueprint.js style shadows (multiple layers for depth)
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
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
          ),
          child: content,
        ),
      ),
    );
  }

}

// Custom shape border for popover with arrow (handles all positions)
class PopoverShapeBorder extends ShapeBorder {
  final BlueprintPopoverPosition position;
  final double arrowWidth;
  final double arrowHeight;
  final double borderRadius;

  const PopoverShapeBorder({
    required this.position,
    this.arrowWidth = 12,
    this.arrowHeight = 6,
    this.borderRadius = 3,
  });

  @override
  EdgeInsetsGeometry get dimensions {
    switch (position) {
      case BlueprintPopoverPosition.top:
      case BlueprintPopoverPosition.topLeft:
      case BlueprintPopoverPosition.topRight:
        return EdgeInsets.only(bottom: arrowHeight); // Arrow points down from popover
      case BlueprintPopoverPosition.bottom:
      case BlueprintPopoverPosition.bottomLeft:
      case BlueprintPopoverPosition.bottomRight:
        return EdgeInsets.only(top: arrowHeight); // Arrow points up from popover
      case BlueprintPopoverPosition.left:
        return EdgeInsets.only(right: arrowHeight); // Arrow points right from popover
      case BlueprintPopoverPosition.right:
        return EdgeInsets.only(left: arrowHeight); // Arrow points left from popover
    }
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    
    // Calculate popover body rect (excluding arrow space)
    Rect popoverRect;
    switch (position) {
      case BlueprintPopoverPosition.top:
      case BlueprintPopoverPosition.topLeft:
      case BlueprintPopoverPosition.topRight:
        // Popover above target, arrow points down
        popoverRect = Rect.fromLTWH(
          rect.left, rect.top, rect.width, rect.height - arrowHeight);
        break;
      case BlueprintPopoverPosition.bottom:
      case BlueprintPopoverPosition.bottomLeft:
      case BlueprintPopoverPosition.bottomRight:
        // Popover below target, arrow points up
        popoverRect = Rect.fromLTWH(
          rect.left, rect.top + arrowHeight, rect.width, rect.height - arrowHeight);
        break;
      case BlueprintPopoverPosition.left:
        // Popover left of target, arrow points right
        popoverRect = Rect.fromLTWH(
          rect.left, rect.top, rect.width - arrowHeight, rect.height);
        break;
      case BlueprintPopoverPosition.right:
        // Popover right of target, arrow points left
        popoverRect = Rect.fromLTWH(
          rect.left + arrowHeight, rect.top, rect.width - arrowHeight, rect.height);
        break;
    }

    // Create rounded rectangle for popover body
    final rrect = RRect.fromRectAndRadius(
      popoverRect,
      Radius.circular(borderRadius),
    );
    path.addRRect(rrect);

    // Add arrow pointing in correct direction
    _addArrowToPath(path, rect, popoverRect);

    return path;
  }

  void _addArrowToPath(Path path, Rect rect, Rect popoverRect) {
    switch (position) {
      case BlueprintPopoverPosition.top:
      case BlueprintPopoverPosition.topLeft:
      case BlueprintPopoverPosition.topRight:
        // Arrow pointing down from popover
        final arrowX = _getArrowCenterX(popoverRect);
        path.moveTo(arrowX - arrowWidth / 2, popoverRect.bottom);
        path.lineTo(arrowX, rect.bottom);
        path.lineTo(arrowX + arrowWidth / 2, popoverRect.bottom);
        break;
      case BlueprintPopoverPosition.bottom:
      case BlueprintPopoverPosition.bottomLeft:
      case BlueprintPopoverPosition.bottomRight:
        // Arrow pointing up from popover
        final arrowX = _getArrowCenterX(popoverRect);
        path.moveTo(arrowX - arrowWidth / 2, popoverRect.top);
        path.lineTo(arrowX, rect.top);
        path.lineTo(arrowX + arrowWidth / 2, popoverRect.top);
        break;
      case BlueprintPopoverPosition.left:
        // Arrow pointing right from popover
        final arrowY = popoverRect.center.dy;
        path.moveTo(popoverRect.right, arrowY - arrowWidth / 2);
        path.lineTo(rect.right, arrowY);
        path.lineTo(popoverRect.right, arrowY + arrowWidth / 2);
        break;
      case BlueprintPopoverPosition.right:
        // Arrow pointing left from popover
        final arrowY = popoverRect.center.dy;
        path.moveTo(popoverRect.left, arrowY - arrowWidth / 2);
        path.lineTo(rect.left, arrowY);
        path.lineTo(popoverRect.left, arrowY + arrowWidth / 2);
        break;
    }
    path.close();
  }

  double _getArrowCenterX(Rect popoverRect) {
    switch (position) {
      case BlueprintPopoverPosition.topLeft:
      case BlueprintPopoverPosition.bottomLeft:
        return popoverRect.left + 20; // 20px from left edge
      case BlueprintPopoverPosition.topRight:
      case BlueprintPopoverPosition.bottomRight:
        return popoverRect.right - 20; // 20px from right edge
      case BlueprintPopoverPosition.top:
      case BlueprintPopoverPosition.bottom:
      default:
        return popoverRect.center.dx; // Centered
    }
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // No additional painting needed - the decoration handles the fill (EXACT copy)
  }

  @override
  ShapeBorder scale(double t) {
    return PopoverShapeBorder(
      position: position,
      arrowWidth: arrowWidth * t,
      arrowHeight: arrowHeight * t,
      borderRadius: borderRadius * t,
    );
  }
}

