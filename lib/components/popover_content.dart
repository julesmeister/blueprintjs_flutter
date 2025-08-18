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
    Key? key,
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
  }) : super(key: key);

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
            child: Stack(
              children: [
                if (!minimal) _buildArrow(),
                _buildPopoverContent(),
              ],
            ),
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
        decoration: BoxDecoration(
          color: minimal ? BlueprintColors.lightGray5 : Colors.white,
          borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
          border: minimal 
              ? Border.all(color: BlueprintColors.gray5, width: 1)
              : null,
          boxShadow: minimal ? null : [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
              spreadRadius: 0,
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

  Widget _buildArrow() {
    const arrowSize = 8.0;
    return Positioned(
      top: _getArrowTop(arrowSize),
      left: _getArrowLeft(arrowSize),
      child: CustomPaint(
        size: Size(arrowSize * 2, arrowSize),
        painter: ArrowPainter(
          color: Colors.white,
          direction: PopoverPositionCalculator.getArrowDirection(position),
        ),
      ),
    );
  }

  double? _getArrowTop(double arrowSize) {
    switch (position) {
      case BlueprintPopoverPosition.top:
      case BlueprintPopoverPosition.topLeft:
      case BlueprintPopoverPosition.topRight:
        return null;
      case BlueprintPopoverPosition.bottom:
      case BlueprintPopoverPosition.bottomLeft:
      case BlueprintPopoverPosition.bottomRight:
        return -arrowSize;
      case BlueprintPopoverPosition.left:
      case BlueprintPopoverPosition.right:
        return null;
    }
  }

  double? _getArrowLeft(double arrowSize) {
    switch (position) {
      case BlueprintPopoverPosition.left:
        return null;
      case BlueprintPopoverPosition.right:
        return -arrowSize * 2;
      case BlueprintPopoverPosition.top:
      case BlueprintPopoverPosition.bottom:
        return null;
      case BlueprintPopoverPosition.topLeft:
      case BlueprintPopoverPosition.bottomLeft:
        return BlueprintTheme.gridSize.toDouble();
      case BlueprintPopoverPosition.topRight:
      case BlueprintPopoverPosition.bottomRight:
        return null;
    }
  }
}

class ArrowPainter extends CustomPainter {
  final Color color;
  final ArrowDirection direction;

  ArrowPainter({required this.color, required this.direction});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final width = size.width;
    final height = size.height;

    switch (direction) {
      case ArrowDirection.up:
        path.moveTo(width / 2, 0);
        path.lineTo(0, height);
        path.lineTo(width, height);
        break;
      case ArrowDirection.down:
        path.moveTo(0, 0);
        path.lineTo(width, 0);
        path.lineTo(width / 2, height);
        break;
      case ArrowDirection.left:
        path.moveTo(0, height / 2);
        path.lineTo(width, 0);
        path.lineTo(width, height);
        break;
      case ArrowDirection.right:
        path.moveTo(0, 0);
        path.lineTo(width, height / 2);
        path.lineTo(0, height);
        break;
      case ArrowDirection.none:
        return; // No arrow to draw
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.direction != direction;
  }
}