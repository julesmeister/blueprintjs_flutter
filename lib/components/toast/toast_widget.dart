import 'package:flutter/material.dart';
import 'dart:async';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import '../blueprint_button.dart';
import 'toast_models.dart';

// Ensure BlueprintIntent is available
export '../blueprint_button.dart' show BlueprintIntent;

/// Individual Toast Widget with animations and styling
class BlueprintToast extends StatefulWidget {
  final BlueprintToastOptions options;
  final VoidCallback? onRemove;

  const BlueprintToast({
    Key? key,
    required this.options,
    this.onRemove,
  }) : super(key: key);

  @override
  State<BlueprintToast> createState() => _BlueprintToastState();
}

class _BlueprintToastState extends State<BlueprintToast>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    
    // Slide animation controller
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // Fade animation controller  
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    // Slide from top animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));
    
    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));
    
    // Start animations
    _slideController.forward();
    _fadeController.forward();
    
    // Start dismiss timer
    _startDismissTimer();
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _startDismissTimer() {
    if (widget.options.timeout.inMilliseconds > 0) {
      _dismissTimer?.cancel();
      _dismissTimer = Timer(widget.options.timeout, _dismiss);
    }
  }

  void _pauseDismissTimer() {
    _dismissTimer?.cancel();
  }

  void _dismiss() async {
    if (!mounted) return;
    
    // Call onDismiss callback
    widget.options.onDismiss?.call();
    
    // Animate out
    await _fadeController.reverse();
    
    // Remove from parent
    widget.onRemove?.call();
  }

  void _onPointerEnter() {
    _pauseDismissTimer();
  }

  void _onPointerExit() {
    _startDismissTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: MouseRegion(
          onEnter: (_) => _onPointerEnter(),
          onExit: (_) => _onPointerExit(),
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 300, // Blueprint: 30 * grid-size
              maxWidth: 500, // Blueprint: 50 * grid-size
              minHeight: 50, // Blueprint: button-height-large
            ),
            margin: const EdgeInsets.only(bottom: 20), // Blueprint: 2 * grid-size
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
              borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(BlueprintTheme.gridSize),
              child: Row(
                children: [
                  // Icon
                  if (widget.options.icon != null || _hasIntentIcon())
                    Container(
                      margin: const EdgeInsets.only(right: BlueprintTheme.gridSize),
                      child: Icon(
                        widget.options.icon ?? _getIntentIcon(),
                        color: _getIconColor(),
                        size: 16,
                      ),
                    ),
                  // Message
                  Expanded(
                    child: Text(
                      widget.options.message,
                      style: TextStyle(
                        color: _getTextColor(),
                        fontSize: BlueprintTheme.fontSize,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  // Action Button
                  if (widget.options.actionText != null)
                    Container(
                      margin: const EdgeInsets.only(left: BlueprintTheme.gridSize),
                      child: BlueprintButton(
                        text: widget.options.actionText!,
                        variant: BlueprintButtonVariant.minimal,
                        intent: widget.options.intent,
                        size: BlueprintButtonSize.small,
                        onPressed: widget.options.onAction,
                      ),
                    ),
                  // Close Button
                  Container(
                    margin: const EdgeInsets.only(left: BlueprintTheme.gridSize),
                    child: BlueprintButton(
                      icon: Icons.close,
                      variant: BlueprintButtonVariant.minimal,
                      size: BlueprintButtonSize.small,
                      onPressed: _dismiss,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _hasIntentIcon() {
    return widget.options.intent != BlueprintIntent.none;
  }

  IconData _getIntentIcon() {
    switch (widget.options.intent) {
      case BlueprintIntent.primary:
        return Icons.info;
      case BlueprintIntent.success:
        return Icons.check_circle;
      case BlueprintIntent.warning:
        return Icons.warning;
      case BlueprintIntent.danger:
        return Icons.error;
      case BlueprintIntent.none:
        return Icons.info;
    }
  }

  Color _getBackgroundColor() {
    switch (widget.options.intent) {
      case BlueprintIntent.primary:
        return BlueprintColors.intentPrimary;
      case BlueprintIntent.success:
        return BlueprintColors.intentSuccess;
      case BlueprintIntent.warning:
        return BlueprintColors.orange5;
      case BlueprintIntent.danger:
        return BlueprintColors.intentDanger;
      case BlueprintIntent.none:
        return BlueprintColors.darkGray2;
    }
  }

  Color _getTextColor() {
    switch (widget.options.intent) {
      case BlueprintIntent.primary:
      case BlueprintIntent.success:
      case BlueprintIntent.danger:
        return Colors.white;
      case BlueprintIntent.warning:
        return BlueprintColors.darkGray1;
      case BlueprintIntent.none:
        return Colors.white;
    }
  }

  Color _getIconColor() {
    return _getTextColor();
  }
}