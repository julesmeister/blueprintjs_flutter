import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_button.dart';

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
      curve: Curves.easeInOut,
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
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        child: AnimatedBuilder(
          animation: _fadeAnimation,
          builder: (context, child) => Opacity(
            opacity: _fadeAnimation.value,
            child: _TooltipPopup(
              content: widget.content,
              intent: widget.intent,
              position: widget.position,
              compact: widget.compact,
              minimal: widget.minimal,
              targetOffset: offset,
              targetSize: size,
              maxWidth: widget.maxWidth,
            ),
          ),
        ),
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

class _TooltipPopup extends StatelessWidget {
  final String content;
  final BlueprintIntent intent;
  final BlueprintTooltipPosition position;
  final bool compact;
  final bool minimal;
  final Offset targetOffset;
  final Size targetSize;
  final double? maxWidth;

  const _TooltipPopup({
    required this.content,
    required this.intent,
    required this.position,
    required this.compact,
    required this.minimal,
    required this.targetOffset,
    required this.targetSize,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final tooltipOffset = _calculateTooltipOffset();
    final arrowOffset = _calculateArrowOffset();

    return Positioned(
      left: tooltipOffset.dx,
      top: tooltipOffset.dy,
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? 300,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!minimal && _shouldShowArrowAbove()) _buildArrow(true),
              _buildTooltipContent(),
              if (!minimal && !_shouldShowArrowAbove()) _buildArrow(false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTooltipContent() {
    return Container(
      padding: EdgeInsets.all(compact ? BlueprintTheme.gridSize * 0.5 : BlueprintTheme.gridSize),
      decoration: BoxDecoration(
        color: _getTooltipColor(),
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        content,
        style: TextStyle(
          color: Colors.white,
          fontSize: compact ? BlueprintTheme.fontSizeSmall : BlueprintTheme.fontSize,
          height: 1.3,
        ),
      ),
    );
  }

  Widget _buildArrow(bool pointsUp) {
    return CustomPaint(
      size: const Size(12, 6),
      painter: _ArrowPainter(
        color: _getTooltipColor(),
        pointsUp: pointsUp,
      ),
    );
  }

  bool _shouldShowArrowAbove() {
    return position == BlueprintTooltipPosition.bottom ||
           position == BlueprintTooltipPosition.bottomLeft ||
           position == BlueprintTooltipPosition.bottomRight;
  }

  Color _getTooltipColor() {
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

  Offset _calculateTooltipOffset() {
    const arrowSize = 6.0;
    const spacing = 8.0;

    switch (position) {
      case BlueprintTooltipPosition.top:
        return Offset(
          targetOffset.dx + (targetSize.width / 2) - 150, // Assuming max width 300, center it
          targetOffset.dy - spacing - arrowSize,
        );
      case BlueprintTooltipPosition.bottom:
        return Offset(
          targetOffset.dx + (targetSize.width / 2) - 150,
          targetOffset.dy + targetSize.height + spacing + arrowSize,
        );
      case BlueprintTooltipPosition.left:
        return Offset(
          targetOffset.dx - spacing - 300, // Max width
          targetOffset.dy + (targetSize.height / 2) - 20, // Estimate tooltip height
        );
      case BlueprintTooltipPosition.right:
        return Offset(
          targetOffset.dx + targetSize.width + spacing,
          targetOffset.dy + (targetSize.height / 2) - 20,
        );
      case BlueprintTooltipPosition.topLeft:
        return Offset(
          targetOffset.dx,
          targetOffset.dy - spacing - arrowSize,
        );
      case BlueprintTooltipPosition.topRight:
        return Offset(
          targetOffset.dx + targetSize.width - 300,
          targetOffset.dy - spacing - arrowSize,
        );
      case BlueprintTooltipPosition.bottomLeft:
        return Offset(
          targetOffset.dx,
          targetOffset.dy + targetSize.height + spacing + arrowSize,
        );
      case BlueprintTooltipPosition.bottomRight:
        return Offset(
          targetOffset.dx + targetSize.width - 300,
          targetOffset.dy + targetSize.height + spacing + arrowSize,
        );
    }
  }

  Offset _calculateArrowOffset() {
    // This would be used for more precise arrow positioning
    // For now, arrows are centered in their containers
    return Offset.zero;
  }
}

class _ArrowPainter extends CustomPainter {
  final Color color;
  final bool pointsUp;

  _ArrowPainter({required this.color, required this.pointsUp});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    if (pointsUp) {
      // Arrow pointing up
      path.moveTo(size.width / 2, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else {
      // Arrow pointing down
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width / 2, size.height);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.pointsUp != pointsUp;
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
}