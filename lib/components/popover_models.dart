import 'package:flutter/material.dart';

enum BlueprintPopoverPosition {
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

enum BlueprintPopoverInteraction {
  click,
  hover,
  manual,
}

enum ArrowDirection {
  up,
  down,
  left,
  right,
  none,
}

class PopoverPositionData {
  final Offset position;
  final ArrowDirection arrowDirection;
  final Offset? arrowPosition;

  const PopoverPositionData({
    required this.position,
    required this.arrowDirection,
    this.arrowPosition,
  });
}