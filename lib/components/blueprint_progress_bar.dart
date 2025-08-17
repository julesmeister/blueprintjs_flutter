import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_button.dart';

class BlueprintProgressBar extends StatefulWidget {
  final double? value;
  final BlueprintIntent intent;
  final bool animate;
  final bool stripes;
  final double? height;
  final String? semanticLabel;

  const BlueprintProgressBar({
    Key? key,
    this.value,
    this.intent = BlueprintIntent.none,
    this.animate = true,
    this.stripes = true,
    this.height,
    this.semanticLabel,
  }) : super(key: key);

  @override
  State<BlueprintProgressBar> createState() => _BlueprintProgressBarState();
}

class _BlueprintProgressBarState extends State<BlueprintProgressBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _stripesController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _stripesController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.value?.clamp(0.0, 1.0) ?? 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.animate) {
      _animationController.forward();
    }

    if (widget.stripes && widget.animate) {
      _stripesController.repeat();
    }
  }

  @override
  void didUpdateWidget(BlueprintProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.value != oldWidget.value) {
      _progressAnimation = Tween<double>(
        begin: _progressAnimation.value,
        end: widget.value?.clamp(0.0, 1.0) ?? 1.0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
      
      if (widget.animate) {
        _animationController.reset();
        _animationController.forward();
      }
    }

    if (widget.stripes != oldWidget.stripes || widget.animate != oldWidget.animate) {
      if (widget.stripes && widget.animate) {
        _stripesController.repeat();
      } else {
        _stripesController.stop();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _stripesController.dispose();
    super.dispose();
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
        return BlueprintColors.blue3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressValue = widget.value?.clamp(0.0, 1.0);
    final barHeight = widget.height ?? 8.0;

    return Semantics(
      label: widget.semanticLabel ?? 'Progress: ${((progressValue ?? 1.0) * 100).round()}%',
      value: progressValue != null ? '${(progressValue * 100).round()}%' : 'Indeterminate',
      child: Container(
        height: barHeight,
        decoration: BoxDecoration(
          color: BlueprintColors.lightGray1,
          borderRadius: BorderRadius.circular(barHeight / 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(barHeight / 2),
          child: widget.animate
              ? AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return _buildProgressMeter(_progressAnimation.value, barHeight);
                  },
                )
              : _buildProgressMeter(progressValue ?? 1.0, barHeight),
        ),
      ),
    );
  }

  Widget _buildProgressMeter(double progress, double height) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: progress,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: _intentColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: widget.stripes ? _buildStripes() : null,
        ),
      ),
    );
  }

  Widget _buildStripes() {
    if (!widget.animate) {
      return _buildStaticStripes();
    }

    return AnimatedBuilder(
      animation: _stripesController,
      builder: (context, child) {
        return _buildAnimatedStripes();
      },
    );
  }

  Widget _buildStaticStripes() {
    return CustomPaint(
      painter: _StripesPainter(
        color: Colors.white.withOpacity(0.15),
        offset: 0.0,
      ),
      child: Container(),
    );
  }

  Widget _buildAnimatedStripes() {
    return CustomPaint(
      painter: _StripesPainter(
        color: Colors.white.withOpacity(0.15),
        offset: _stripesController.value * 20.0,
      ),
      child: Container(),
    );
  }
}

class _StripesPainter extends CustomPainter {
  final Color color;
  final double offset;

  _StripesPainter({required this.color, required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    const stripeWidth = 6.0;
    const stripeSpacing = 6.0;
    final totalWidth = stripeWidth + stripeSpacing;

    for (double x = -totalWidth + (offset % totalWidth); x < size.width + totalWidth; x += totalWidth) {
      final path = Path()
        ..moveTo(x, 0)
        ..lineTo(x + stripeWidth, 0)
        ..lineTo(x + stripeWidth + size.height, size.height)
        ..lineTo(x + size.height, size.height)
        ..close();
      
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_StripesPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.offset != offset;
  }
}

// Convenience factory methods
class BlueprintProgressBars {
  static Widget determinate({
    required double value,
    BlueprintIntent intent = BlueprintIntent.primary,
    bool animate = true,
    bool stripes = true,
    double? height,
    String? semanticLabel,
  }) {
    return BlueprintProgressBar(
      value: value,
      intent: intent,
      animate: animate,
      stripes: stripes,
      height: height,
      semanticLabel: semanticLabel,
    );
  }

  static Widget indeterminate({
    BlueprintIntent intent = BlueprintIntent.primary,
    bool animate = true,
    bool stripes = true,
    double? height,
    String? semanticLabel,
  }) {
    return BlueprintProgressBar(
      intent: intent,
      animate: animate,
      stripes: stripes,
      height: height,
      semanticLabel: semanticLabel,
    );
  }

  static Widget small({
    double? value,
    BlueprintIntent intent = BlueprintIntent.primary,
    bool animate = true,
    bool stripes = true,
  }) {
    return BlueprintProgressBar(
      value: value,
      intent: intent,
      animate: animate,
      stripes: stripes,
      height: 4.0,
    );
  }

  static Widget large({
    double? value,
    BlueprintIntent intent = BlueprintIntent.primary,
    bool animate = true,
    bool stripes = true,
  }) {
    return BlueprintProgressBar(
      value: value,
      intent: intent,
      animate: animate,
      stripes: stripes,
      height: 12.0,
    );
  }
}