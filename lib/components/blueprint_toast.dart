import 'package:flutter/material.dart';
import 'toast/toast_models.dart';
import 'toast/toast_queue.dart';
import 'blueprint_common.dart';

// Re-export all toast components for easy importing
export 'toast/toast_models.dart';
export 'toast/toast_queue.dart';
export 'toast/toast_widget.dart';

/// Main toast API for showing toasts globally
class BlueprintToasts {
  static BlueprintToasterState? _globalToaster;

  /// Initialize global toaster (call this in your main widget)
  static void initialize(BlueprintToasterState toaster) {
    _globalToaster = toaster;
  }

  /// Show toast using global toaster
  static void show(BlueprintToastOptions options) {
    _globalToaster?.show(options);
  }

  /// Show info toast
  static void info(String message, {String? actionText, VoidCallback? onAction}) {
    show(BlueprintToastOptions(
      message: message,
      intent: BlueprintIntent.primary,
      actionText: actionText,
      onAction: onAction,
    ));
  }

  /// Show success toast
  static void success(String message, {String? actionText, VoidCallback? onAction}) {
    show(BlueprintToastOptions(
      message: message,
      intent: BlueprintIntent.success,
      actionText: actionText,
      onAction: onAction,
    ));
  }

  /// Show warning toast
  static void warning(String message, {String? actionText, VoidCallback? onAction}) {
    show(BlueprintToastOptions(
      message: message,
      intent: BlueprintIntent.warning,
      actionText: actionText,
      onAction: onAction,
    ));
  }

  /// Show danger/error toast
  static void danger(String message, {String? actionText, VoidCallback? onAction}) {
    show(BlueprintToastOptions(
      message: message,
      intent: BlueprintIntent.danger,
      actionText: actionText,
      onAction: onAction,
    ));
  }

  /// Clear all toasts
  static void clear() {
    _globalToaster?.clear();
  }
}

/// Factory Methods for Easy Toast Creation
class BlueprintToastFactory {
  /// Create a toaster widget
  static Widget createToaster({
    BlueprintToastPosition position = BlueprintToastPosition.topRight,
    List<BlueprintToastOptions> children = const [],
  }) {
    return BlueprintToaster(
      position: position,
      children: children,
    );
  }

  /// Create a simple toast
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

  /// Create a toast with action button
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

  /// Create a persistent toast (no auto-dismiss)
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