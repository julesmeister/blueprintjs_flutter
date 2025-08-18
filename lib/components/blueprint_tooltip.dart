import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'blueprint_button.dart';

enum BlueprintTooltipPosition {
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class BlueprintTooltip extends StatefulWidget {
  final Widget child;
  final String content;
  final BlueprintIntent intent;
  final BlueprintTooltipPosition position;
  final bool compact;
  final bool minimal;
  final Duration hoverOpenDelay;
  final Duration hoverCloseDelay;
  final Duration transitionDuration;
  final bool disabled;
  final double? maxWidth;

  const BlueprintTooltip({
    Key? key,
    required this.child,
    required this.content,
    this.intent = BlueprintIntent.none,
    this.position = BlueprintTooltipPosition.top,
    this.compact = false,
    this.minimal = false,
    this.hoverOpenDelay = const Duration(milliseconds: 100),
    this.hoverCloseDelay = const Duration(milliseconds: 0),
    this.transitionDuration = const Duration(milliseconds: 100),
    this.disabled = false,
    this.maxWidth,
  }) : super(key: key);

  @override
  State<BlueprintTooltip> createState() => _BlueprintTooltipState();
}

class _BlueprintTooltipState extends State<BlueprintTooltip>
    with TickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.transitionDuration,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _removeOverlay();
    _animationController.dispose();
    super.dispose();
  }

  void _showTooltip() {
    if (widget.disabled || _overlayEntry != null) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
  }

  void _hideTooltip() {
    if (_overlayEntry == null) return;

    _animationController.reverse().then((_) {
      _removeOverlay();
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final targetSize = renderBox.size;
    final targetOffset = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;

    return OverlayEntry(
      builder: (context) => _TooltipOverlay(
        content: widget.content,
        intent: widget.intent,
        position: widget.position,
        compact: widget.compact,
        minimal: widget.minimal,
        targetOffset: targetOffset,
        targetSize: targetSize,
        screenSize: screenSize,
        maxWidth: widget.maxWidth,
        animationController: _animationController,
        fadeAnimation: _fadeAnimation,
      ),
    );
  }

  void _onPointerEnter(PointerEvent event) {
    _isHovering = true;
    Future.delayed(widget.hoverOpenDelay, () {
      if (_isHovering && mounted) {
        _showTooltip();
      }
    });
  }

  void _onPointerExit(PointerEvent event) {
    _isHovering = false;
    if (widget.hoverCloseDelay.inMilliseconds > 0) {
      Future.delayed(widget.hoverCloseDelay, () {
        if (!_isHovering && mounted) {
          _hideTooltip();
        }
      });
    } else {
      _hideTooltip();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.disabled) {
      return widget.child;
    }

    return MouseRegion(
      onEnter: _onPointerEnter,
      onExit: _onPointerExit,
      child: widget.child,
    );
  }
}

class _TooltipOverlay extends StatelessWidget {
  final String content;
  final BlueprintIntent intent;
  final BlueprintTooltipPosition position;
  final bool compact;
  final bool minimal;
  final Offset targetOffset;
  final Size targetSize;
  final Size screenSize;
  final double? maxWidth;
  final AnimationController animationController;
  final Animation<double> fadeAnimation;

  const _TooltipOverlay({
    required this.content,
    required this.intent,
    required this.position,
    required this.compact,
    required this.minimal,
    required this.targetOffset,
    required this.targetSize,
    required this.screenSize,
    this.maxWidth,
    required this.animationController,
    required this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final tooltipMaxWidth = maxWidth ?? 200.0;
    
    // Blueprint.js uses 4px spacing from target (arrow-target-offset: -4px)
    const spacing = 4.0;
    const arrowSize = 22.0; // Blueprint's 22px arrow-square-size for tooltips
    const arrowHalfSize = 11.0;
    
    final calculatedPosition = _calculatePosition(spacing, tooltipMaxWidth);
    
    return Positioned(
      left: calculatedPosition.dx,
      top: calculatedPosition.dy,
      child: AnimatedBuilder(
        animation: fadeAnimation,
        builder: (context, child) => FadeTransition(
          opacity: fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Arrow/caret (behind content)
                if (!minimal) _buildArrow(arrowHalfSize),
                // Tooltip content (in front)
                Container(
                  constraints: BoxConstraints(maxWidth: tooltipMaxWidth),
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: minimal ? null : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: compact ? 7 : 12,
                    vertical: compact ? 5 : 10,
                  ),
                  child: Text(
                    content,
                    style: TextStyle(
                      color: _getTextColor(),
                      fontSize: compact ? 11 : 14,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Offset _calculatePosition(double spacing, double tooltipMaxWidth) {
    double dx = 0;
    double dy = 0;
    const tooltipHeight = 32.0; // Approximate height
    
    // Calculate base position
    switch (position) {
      case BlueprintTooltipPosition.top:
        dx = targetOffset.dx + (targetSize.width / 2) - (tooltipMaxWidth / 2);
        dy = targetOffset.dy - tooltipHeight - spacing;
        break;
      case BlueprintTooltipPosition.bottom:
        dx = targetOffset.dx + (targetSize.width / 2) - (tooltipMaxWidth / 2);
        dy = targetOffset.dy + targetSize.height + spacing;
        break;
      case BlueprintTooltipPosition.left:
        dx = targetOffset.dx - tooltipMaxWidth - spacing;
        dy = targetOffset.dy + (targetSize.height / 2) - (tooltipHeight / 2);
        break;
      case BlueprintTooltipPosition.right:
        dx = targetOffset.dx + targetSize.width + spacing;
        dy = targetOffset.dy + (targetSize.height / 2) - (tooltipHeight / 2);
        break;
      case BlueprintTooltipPosition.topLeft:
        dx = targetOffset.dx;
        dy = targetOffset.dy - tooltipHeight - spacing;
        break;
      case BlueprintTooltipPosition.topRight:
        dx = targetOffset.dx + targetSize.width - tooltipMaxWidth;
        dy = targetOffset.dy - tooltipHeight - spacing;
        break;
      case BlueprintTooltipPosition.bottomLeft:
        dx = targetOffset.dx;
        dy = targetOffset.dy + targetSize.height + spacing;
        break;
      case BlueprintTooltipPosition.bottomRight:
        dx = targetOffset.dx + targetSize.width - tooltipMaxWidth;
        dy = targetOffset.dy + targetSize.height + spacing;
        break;
    }
    
    // Constrain to screen bounds
    dx = dx.clamp(8.0, screenSize.width - tooltipMaxWidth - 8.0);
    dy = dy.clamp(8.0, screenSize.height - tooltipHeight - 8.0);
    
    return Offset(dx, dy);
  }

  Widget _buildArrow(double arrowHalfSize) {
    double? left, top, right, bottom;
    
    // Position arrow relative to the tooltip container
    switch (position) {
      case BlueprintTooltipPosition.top:
      case BlueprintTooltipPosition.topLeft:
      case BlueprintTooltipPosition.topRight:
        // Arrow below tooltip, pointing down
        bottom = -arrowHalfSize + 3; // Blueprint: translateY(-3px)
        if (position == BlueprintTooltipPosition.topLeft) {
          left = 16;
        } else if (position == BlueprintTooltipPosition.topRight) {
          right = 16;
        } else {
          left = null; // Will be centered by not setting left/right
        }
        break;
      case BlueprintTooltipPosition.bottom:
      case BlueprintTooltipPosition.bottomLeft:
      case BlueprintTooltipPosition.bottomRight:
        // Arrow above tooltip, pointing up
        top = -arrowHalfSize - 3; // Blueprint: translateY(3px)
        if (position == BlueprintTooltipPosition.bottomLeft) {
          left = 16;
        } else if (position == BlueprintTooltipPosition.bottomRight) {
          right = 16;
        } else {
          left = null; // Will be centered
        }
        break;
      case BlueprintTooltipPosition.left:
        // Arrow to the right of tooltip, pointing right
        right = -arrowHalfSize + 3; // Blueprint: translateX(-3px)
        top = null; // Will be centered vertically
        break;
      case BlueprintTooltipPosition.right:
        // Arrow to the left of tooltip, pointing left
        left = -arrowHalfSize - 3; // Blueprint: translateX(3px)
        top = null; // Will be centered vertically
        break;
    }
    
    Widget arrow = Transform.rotate(
      angle: 0.785398, // 45 degrees in radians
      child: Container(
        width: arrowHalfSize * 1.41421356, // sqrt(2) * halfsize for diagonal
        height: arrowHalfSize * 1.41421356,
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
    
    // Center the arrow if left/top are not specified
    if (left == null && right == null) {
      // Horizontally centered
      return Positioned(
        left: 0,
        right: 0,
        top: top,
        bottom: bottom,
        child: Align(
          alignment: Alignment.center,
          child: arrow,
        ),
      );
    } else if (top == null && bottom == null) {
      // Vertically centered
      return Positioned(
        left: left,
        right: right,
        top: 0,
        bottom: 0,
        child: Align(
          alignment: Alignment.center,
          child: arrow,
        ),
      );
    } else {
      // Fixed position
      return Positioned(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        child: arrow,
      );
    }
  }


  Color _getBackgroundColor() {
    if (minimal) {
      return BlueprintColors.lightGray1;
    }
    
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
        return BlueprintColors.darkGray2;
    }
  }

  Color _getTextColor() {
    if (minimal) {
      return BlueprintColors.textColor;
    }
    return Colors.white;
  }
}

// Convenience factory methods
class BlueprintTooltips {
  static Widget simple({
    required Widget child,
    required String content,
    BlueprintTooltipPosition position = BlueprintTooltipPosition.top,
    bool disabled = false,
  }) {
    return BlueprintTooltip(
      content: content,
      position: position,
      disabled: disabled,
      child: child,
    );
  }

  static Widget intent({
    required Widget child,
    required String content,
    required BlueprintIntent intent,
    BlueprintTooltipPosition position = BlueprintTooltipPosition.top,
    bool disabled = false,
  }) {
    return BlueprintTooltip(
      content: content,
      intent: intent,
      position: position,
      disabled: disabled,
      child: child,
    );
  }

  static Widget compact({
    required Widget child,
    required String content,
    BlueprintTooltipPosition position = BlueprintTooltipPosition.top,
    bool disabled = false,
  }) {
    return BlueprintTooltip(
      content: content,
      position: position,
      compact: true,
      disabled: disabled,
      child: child,
    );
  }

  static Widget minimal({
    required Widget child,
    required String content,
    BlueprintTooltipPosition position = BlueprintTooltipPosition.top,
    bool disabled = false,
  }) {
    return BlueprintTooltip(
      content: content,
      position: position,
      minimal: true,
      disabled: disabled,
      child: child,
    );
  }

  static Widget forButton({
    required Widget button,
    required String content,
    BlueprintTooltipPosition position = BlueprintTooltipPosition.top,
  }) {
    return BlueprintTooltip(
      content: content,
      position: position,
      compact: true,
      child: button,
    );
  }

  static Widget forIcon({
    required Widget icon,
    required String content,
    BlueprintTooltipPosition position = BlueprintTooltipPosition.top,
  }) {
    return BlueprintTooltip(
      content: content,
      position: position,
      compact: true,
      minimal: true,
      child: icon,
    );
  }
}

