import 'package:flutter/material.dart';
import 'popover_models.dart';

class PopoverPositionDelegate extends SingleChildLayoutDelegate {
  final Offset targetOffset;
  final Size targetSize;
  final BlueprintPopoverPosition position;
  final Size screenSize;
  final bool minimal;

  PopoverPositionDelegate({
    required this.targetOffset,
    required this.targetSize,
    required this.position,
    required this.screenSize,
    required this.minimal,
  });

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    const spacing = 12.0;
    const arrowSize = 8.0;
    final actualSpacing = minimal ? spacing : spacing + arrowSize;
    
    double x, y;

    switch (position) {
      case BlueprintPopoverPosition.top:
        x = targetOffset.dx + (targetSize.width - childSize.width) / 2;
        y = targetOffset.dy - childSize.height - actualSpacing;
        break;
      case BlueprintPopoverPosition.bottom:
        x = targetOffset.dx + (targetSize.width - childSize.width) / 2;
        y = targetOffset.dy + targetSize.height + actualSpacing;
        break;
      case BlueprintPopoverPosition.left:
        x = targetOffset.dx - childSize.width - actualSpacing;
        y = targetOffset.dy + (targetSize.height - childSize.height) / 2;
        break;
      case BlueprintPopoverPosition.right:
        x = targetOffset.dx + targetSize.width + actualSpacing;
        y = targetOffset.dy + (targetSize.height - childSize.height) / 2;
        break;
      case BlueprintPopoverPosition.topLeft:
        x = targetOffset.dx;
        y = targetOffset.dy - childSize.height - actualSpacing;
        break;
      case BlueprintPopoverPosition.topRight:
        x = targetOffset.dx + targetSize.width - childSize.width;
        y = targetOffset.dy - childSize.height - actualSpacing;
        break;
      case BlueprintPopoverPosition.bottomLeft:
        x = targetOffset.dx;
        y = targetOffset.dy + targetSize.height + actualSpacing;
        break;
      case BlueprintPopoverPosition.bottomRight:
        x = targetOffset.dx + targetSize.width - childSize.width;
        y = targetOffset.dy + targetSize.height + actualSpacing;
        break;
    }

    // Constrain to screen bounds with padding
    x = x.clamp(12.0, screenSize.width - childSize.width - 12.0);
    y = y.clamp(12.0, screenSize.height - childSize.height - 12.0);

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(covariant PopoverPositionDelegate oldDelegate) {
    return targetOffset != oldDelegate.targetOffset ||
           targetSize != oldDelegate.targetSize ||
           position != oldDelegate.position ||
           screenSize != oldDelegate.screenSize ||
           minimal != oldDelegate.minimal;
  }
}

class PopoverPositionCalculator {
  static ArrowDirection getArrowDirection(BlueprintPopoverPosition position) {
    switch (position) {
      case BlueprintPopoverPosition.top:
      case BlueprintPopoverPosition.topLeft:
      case BlueprintPopoverPosition.topRight:
        return ArrowDirection.down;
      case BlueprintPopoverPosition.bottom:
      case BlueprintPopoverPosition.bottomLeft:
      case BlueprintPopoverPosition.bottomRight:
        return ArrowDirection.up;
      case BlueprintPopoverPosition.left:
        return ArrowDirection.right;
      case BlueprintPopoverPosition.right:
        return ArrowDirection.left;
    }
  }

  static Offset getArrowPosition(
    BlueprintPopoverPosition position,
    Offset popoverOffset,
    Size popoverSize,
    Offset targetOffset,
    Size targetSize,
  ) {
    const arrowSize = 8.0;
    
    switch (position) {
      case BlueprintPopoverPosition.top:
      case BlueprintPopoverPosition.bottom:
        final targetCenter = targetOffset.dx + targetSize.width / 2;
        final popoverLeft = popoverOffset.dx;
        final popoverRight = popoverOffset.dx + popoverSize.width;
        final arrowX = (targetCenter - popoverLeft).clamp(arrowSize, popoverSize.width - arrowSize);
        return position == BlueprintPopoverPosition.top
            ? Offset(arrowX, popoverSize.height)
            : Offset(arrowX, 0);
            
      case BlueprintPopoverPosition.left:
      case BlueprintPopoverPosition.right:
        final targetCenter = targetOffset.dy + targetSize.height / 2;
        final popoverTop = popoverOffset.dy;
        final popoverBottom = popoverOffset.dy + popoverSize.height;
        final arrowY = (targetCenter - popoverTop).clamp(arrowSize, popoverSize.height - arrowSize);
        return position == BlueprintPopoverPosition.left
            ? Offset(popoverSize.width, arrowY)
            : Offset(0, arrowY);
            
      case BlueprintPopoverPosition.topLeft:
      case BlueprintPopoverPosition.topRight:
        return Offset(
          position == BlueprintPopoverPosition.topLeft ? 16.0 : popoverSize.width - 16.0,
          popoverSize.height,
        );
        
      case BlueprintPopoverPosition.bottomLeft:
      case BlueprintPopoverPosition.bottomRight:
        return Offset(
          position == BlueprintPopoverPosition.bottomLeft ? 16.0 : popoverSize.width - 16.0,
          0,
        );
    }
  }
}