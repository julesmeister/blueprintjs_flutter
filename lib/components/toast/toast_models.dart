import 'package:flutter/material.dart';
import '../blueprint_button.dart';
import '../blueprint_common.dart';

/// Toast Position Options
enum BlueprintToastPosition {
  top,
  topLeft,
  topRight,
  bottom,
  bottomLeft,
  bottomRight,
}

/// Toast Data Structure
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

/// Toast instance for queue management
class ToastInstance {
  final String id;
  final BlueprintToastOptions options;
  final DateTime createdAt;
  
  ToastInstance({
    required this.id,
    required this.options,
  }) : createdAt = DateTime.now();
}