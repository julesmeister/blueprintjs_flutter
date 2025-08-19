import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_common.dart';

enum BlueprintSpinnerSize {
  small(20),
  standard(50),
  large(100);

  const BlueprintSpinnerSize(this.pixels);
  final double pixels;
}

class BlueprintSpinner extends StatefulWidget {
  final double? size;
  final BlueprintSpinnerSize? spinnerSize;
  final BlueprintIntent intent;
  final double? value;
  final Color? color;
  final double? strokeWidth;

  const BlueprintSpinner({
    super.key,
    this.size,
    this.spinnerSize,
    this.intent = BlueprintIntent.none,
    this.value,
    this.color,
    this.strokeWidth,
  });

  @override
  State<BlueprintSpinner> createState() => _BlueprintSpinnerState();
}

class _BlueprintSpinnerState extends State<BlueprintSpinner>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _strokeController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _strokeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    if (widget.value == null) {
      // Indeterminate spinner
      _rotationController.repeat();
      _strokeController.repeat();
    }
  }

  @override
  void didUpdateWidget(BlueprintSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value == null) {
        _rotationController.repeat();
        _strokeController.repeat();
      } else {
        _rotationController.stop();
        _strokeController.stop();
      }
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _strokeController.dispose();
    super.dispose();
  }

  double get _actualSize {
    if (widget.size != null) {
      return math.max(10, widget.size!);
    }
    return widget.spinnerSize?.pixels ?? BlueprintSpinnerSize.standard.pixels;
  }

  Color get _spinnerColor {
    if (widget.color != null) return widget.color!;
    
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

  double get _strokeWidthValue {
    if (widget.strokeWidth != null) return widget.strokeWidth!;
    
    // Keep stroke width consistent at all sizes (similar to Blueprint)
    const minStrokeWidth = 16;
    const strokeWidth = 4;
    final largeSize = BlueprintSpinnerSize.large.pixels;
    return math.min(minStrokeWidth.toDouble(), (strokeWidth * largeSize) / _actualSize);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _actualSize,
      height: _actualSize,
      child: widget.value != null
          ? _buildDeterminateSpinner()
          : _buildIndeterminateSpinner(),
    );
  }

  Widget _buildIndeterminateSpinner() {
    return AnimatedBuilder(
      animation: Listenable.merge([_rotationController, _strokeController]),
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationController.value * 2 * math.pi,
          child: CustomPaint(
            size: Size(_actualSize, _actualSize),
            painter: _SpinnerPainter(
              color: _spinnerColor,
              strokeWidth: _strokeWidthValue,
              progress: 0.25 + (_strokeController.value * 0.5),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDeterminateSpinner() {
    final progress = widget.value!.clamp(0.0, 1.0);
    return CustomPaint(
      size: Size(_actualSize, _actualSize),
      painter: _SpinnerPainter(
        color: _spinnerColor,
        strokeWidth: _strokeWidthValue,
        progress: progress,
        showTrack: true,
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double progress;
  final bool showTrack;

  _SpinnerPainter({
    required this.color,
    required this.strokeWidth,
    required this.progress,
    this.showTrack = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw track (background circle) for determinate spinner
    if (showTrack) {
      final trackPaint = Paint()
        ..color = color.withValues(alpha: 0.2)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawCircle(center, radius, trackPaint);
    }

    // Draw progress arc
    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_SpinnerPainter oldDelegate) {
    return oldDelegate.color != color ||
           oldDelegate.strokeWidth != strokeWidth ||
           oldDelegate.progress != progress ||
           oldDelegate.showTrack != showTrack;
  }
}

// Convenience factory methods
class BlueprintSpinners {
  static Widget small({
    BlueprintIntent intent = BlueprintIntent.none,
    Color? color,
  }) {
    return BlueprintSpinner(
      spinnerSize: BlueprintSpinnerSize.small,
      intent: intent,
      color: color,
    );
  }

  static Widget standard({
    BlueprintIntent intent = BlueprintIntent.none,
    Color? color,
  }) {
    return BlueprintSpinner(
      spinnerSize: BlueprintSpinnerSize.standard,
      intent: intent,
      color: color,
    );
  }

  static Widget large({
    BlueprintIntent intent = BlueprintIntent.none,
    Color? color,
  }) {
    return BlueprintSpinner(
      spinnerSize: BlueprintSpinnerSize.large,
      intent: intent,
      color: color,
    );
  }

  static Widget progress({
    required double value,
    double size = 50,
    BlueprintIntent intent = BlueprintIntent.primary,
    Color? color,
  }) {
    return BlueprintSpinner(
      size: size,
      value: value,
      intent: intent,
      color: color,
    );
  }

  static Widget inline({
    BlueprintIntent intent = BlueprintIntent.none,
    Color? color,
  }) {
    return BlueprintSpinner(
      size: 16,
      intent: intent,
      color: color,
    );
  }
}