import 'package:flutter/material.dart';
import 'dart:async';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_button.dart';

// Toast Position Options
enum BlueprintToastPosition {
  top,
  topLeft,
  topRight,
  bottom,
  bottomLeft,
  bottomRight,
}

// Toast Data Structure
class BlueprintToastOptions {
  final String message;
  final BlueprintIntent intent;
  final IconData? icon;
  final Duration timeout;
  final String? actionText;
  final VoidCallback? onAction;
  final VoidCallback? onDismiss;
  final String? className;
  final String? key;

  const BlueprintToastOptions({
    required this.message,
    this.intent = BlueprintIntent.none,
    this.icon,
    this.timeout = const Duration(seconds: 5),
    this.actionText,
    this.onAction,
    this.onDismiss,
    this.className,
    this.key,
  });
}

// Individual Toast Widget
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
  bool _isHovered = false;

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
    setState(() => _isHovered = true);
    _pauseDismissTimer();
  }

  void _onPointerExit() {
    setState(() => _isHovered = false);
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
    return _getTextColor().withOpacity(0.7);
  }
}

// Toast Container/Manager
class BlueprintToaster extends StatefulWidget {
  final BlueprintToastPosition position;
  final List<BlueprintToastOptions> children;

  const BlueprintToaster({
    Key? key,
    this.position = BlueprintToastPosition.top,
    this.children = const [],
  }) : super(key: key);

  @override
  State<BlueprintToaster> createState() => BlueprintToasterState();
}

class BlueprintToasterState extends State<BlueprintToaster> {
  final List<BlueprintToastOptions> _toasts = [];

  @override
  void initState() {
    super.initState();
    _toasts.addAll(widget.children);
  }

  void show(BlueprintToastOptions options) {
    if (mounted) {
      setState(() {
        _toasts.add(options);
      });
    }
  }

  void clear() {
    if (mounted) {
      setState(() {
        _toasts.clear();
      });
    }
  }

  void _removeToast(int index) {
    if (mounted && index >= 0 && index < _toasts.length) {
      setState(() {
        _toasts.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_toasts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: _isTopPosition() ? 20 : null,
      bottom: _isBottomPosition() ? 20 : null,
      left: _isLeftPosition() ? 20 : null,
      right: _isRightPosition() ? 20 : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: _getCrossAxisAlignment(),
        children: [
          for (int i = 0; i < _toasts.length; i++)
            BlueprintToast(
              key: ValueKey(_toasts[i].key ?? i),
              options: _toasts[i],
              onRemove: () => _removeToast(i),
            ),
        ],
      ),
    );
  }

  bool _isTopPosition() {
    return widget.position == BlueprintToastPosition.top ||
           widget.position == BlueprintToastPosition.topLeft ||
           widget.position == BlueprintToastPosition.topRight;
  }

  bool _isBottomPosition() {
    return widget.position == BlueprintToastPosition.bottom ||
           widget.position == BlueprintToastPosition.bottomLeft ||
           widget.position == BlueprintToastPosition.bottomRight;
  }

  bool _isLeftPosition() {
    return widget.position == BlueprintToastPosition.topLeft ||
           widget.position == BlueprintToastPosition.bottomLeft;
  }

  bool _isRightPosition() {
    return widget.position == BlueprintToastPosition.topRight ||
           widget.position == BlueprintToastPosition.bottomRight;
  }

  CrossAxisAlignment _getCrossAxisAlignment() {
    if (_isLeftPosition()) {
      return CrossAxisAlignment.start;
    } else if (_isRightPosition()) {
      return CrossAxisAlignment.end;
    } else {
      return CrossAxisAlignment.center;
    }
  }
}

// Global Toaster Singleton
class BlueprintToasts {
  static BlueprintToasterState? _globalToaster;

  // Initialize global toaster (call this in your main widget)
  static void initialize(BlueprintToasterState toaster) {
    _globalToaster = toaster;
  }

  // Show toast using global toaster
  static void show(BlueprintToastOptions options) {
    _globalToaster?.show(options);
  }

  // Convenience methods
  static void info(String message, {String? actionText, VoidCallback? onAction}) {
    show(BlueprintToastOptions(
      message: message,
      intent: BlueprintIntent.primary,
      actionText: actionText,
      onAction: onAction,
    ));
  }

  static void success(String message, {String? actionText, VoidCallback? onAction}) {
    show(BlueprintToastOptions(
      message: message,
      intent: BlueprintIntent.success,
      actionText: actionText,
      onAction: onAction,
    ));
  }

  static void warning(String message, {String? actionText, VoidCallback? onAction}) {
    show(BlueprintToastOptions(
      message: message,
      intent: BlueprintIntent.warning,
      actionText: actionText,
      onAction: onAction,
    ));
  }

  static void danger(String message, {String? actionText, VoidCallback? onAction}) {
    show(BlueprintToastOptions(
      message: message,
      intent: BlueprintIntent.danger,
      actionText: actionText,
      onAction: onAction,
    ));
  }

  static void clear() {
    _globalToaster?.clear();
  }
}

// Factory Methods for Easy Toast Creation
class BlueprintToastFactory {
  static Widget createToaster({
    BlueprintToastPosition position = BlueprintToastPosition.top,
    List<BlueprintToastOptions> children = const [],
  }) {
    return BlueprintToaster(
      position: position,
      children: children,
    );
  }

  static BlueprintToastOptions simple({
    required String message,
    BlueprintIntent intent = BlueprintIntent.none,
    IconData? icon,
    Duration timeout = const Duration(seconds: 5),
  }) {
    return BlueprintToastOptions(
      message: message,
      intent: intent,
      icon: icon,
      timeout: timeout,
    );
  }

  static BlueprintToastOptions withAction({
    required String message,
    required String actionText,
    required VoidCallback onAction,
    BlueprintIntent intent = BlueprintIntent.none,
    IconData? icon,
    Duration timeout = const Duration(seconds: 5),
  }) {
    return BlueprintToastOptions(
      message: message,
      intent: intent,
      icon: icon,
      timeout: timeout,
      actionText: actionText,
      onAction: onAction,
    );
  }

  static BlueprintToastOptions persistent({
    required String message,
    BlueprintIntent intent = BlueprintIntent.none,
    IconData? icon,
    String? actionText,
    VoidCallback? onAction,
  }) {
    return BlueprintToastOptions(
      message: message,
      intent: intent,
      icon: icon,
      timeout: Duration.zero, // No timeout
      actionText: actionText,
      onAction: onAction,
    );
  }
}