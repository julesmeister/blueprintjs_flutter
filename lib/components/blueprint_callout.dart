import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_button.dart';

class BlueprintCallout extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? content;
  final IconData? icon;
  final BlueprintIntent intent;
  final bool compact;
  final bool minimal;
  final VoidCallback? onDismiss;

  const BlueprintCallout({
    Key? key,
    this.child,
    this.title,
    this.content,
    this.icon,
    this.intent = BlueprintIntent.none,
    this.compact = false,
    this.minimal = false,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasBodyContent = child != null || content != null;
    final iconToShow = _getIcon();

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: compact ? BlueprintTheme.gridSize * 0.5 : BlueprintTheme.gridSize,
      ),
      padding: EdgeInsets.all(
        compact ? BlueprintTheme.gridSize : BlueprintTheme.gridSize * 1.5,
      ),
      decoration: BoxDecoration(
        color: minimal ? Colors.transparent : _getBackgroundColor(),
        border: minimal ? Border.all(color: _getBorderColor(), width: 1) : null,
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (iconToShow != null) ...[
            Icon(
              iconToShow,
              color: _getIconColor(),
              size: compact ? 16 : 20,
            ),
            SizedBox(width: compact ? BlueprintTheme.gridSize * 0.5 : BlueprintTheme.gridSize),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: compact ? BlueprintTheme.fontSize : BlueprintTheme.fontSizeLarge,
                      fontWeight: FontWeight.w600,
                      color: _getTitleColor(),
                      height: 1.2,
                    ),
                  ),
                  if (hasBodyContent) 
                    SizedBox(height: compact ? BlueprintTheme.gridSize * 0.5 : BlueprintTheme.gridSize),
                ],
                if (content != null)
                  Text(
                    content!,
                    style: TextStyle(
                      fontSize: BlueprintTheme.fontSize,
                      color: _getContentColor(),
                      height: 1.4,
                    ),
                  ),
                if (child != null)
                  child!,
              ],
            ),
          ),
          if (onDismiss != null) ...[
            const SizedBox(width: BlueprintTheme.gridSize),
            GestureDetector(
              onTap: onDismiss,
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: _getIconColor().withOpacity(0.7),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData? _getIcon() {
    if (icon != null) return icon;

    switch (intent) {
      case BlueprintIntent.primary:
        return Icons.info_outline;
      case BlueprintIntent.success:
        return Icons.check_circle_outline;
      case BlueprintIntent.warning:
        return Icons.warning_amber_outlined;
      case BlueprintIntent.danger:
        return Icons.error_outline;
      case BlueprintIntent.none:
        return null;
    }
  }

  Color _getBackgroundColor() {
    if (minimal) return Colors.transparent;

    switch (intent) {
      case BlueprintIntent.primary:
        return BlueprintColors.intentPrimary.withOpacity(0.1);
      case BlueprintIntent.success:
        return BlueprintColors.intentSuccess.withOpacity(0.1);
      case BlueprintIntent.warning:
        return BlueprintColors.intentWarning.withOpacity(0.1);
      case BlueprintIntent.danger:
        return BlueprintColors.intentDanger.withOpacity(0.1);
      case BlueprintIntent.none:
        return BlueprintColors.lightGray4;
    }
  }

  Color _getBorderColor() {
    switch (intent) {
      case BlueprintIntent.primary:
        return BlueprintColors.intentPrimary.withOpacity(0.3);
      case BlueprintIntent.success:
        return BlueprintColors.intentSuccess.withOpacity(0.3);
      case BlueprintIntent.warning:
        return BlueprintColors.intentWarning.withOpacity(0.3);
      case BlueprintIntent.danger:
        return BlueprintColors.intentDanger.withOpacity(0.3);
      case BlueprintIntent.none:
        return BlueprintColors.lightGray2;
    }
  }

  Color _getIconColor() {
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
        return BlueprintColors.gray2;
    }
  }

  Color _getTitleColor() {
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
        return BlueprintColors.headingColor;
    }
  }

  Color _getContentColor() {
    return BlueprintColors.textColor;
  }
}

// Convenience factory methods
class BlueprintCallouts {
  static Widget info({
    String? title,
    String? content,
    Widget? child,
    IconData? icon,
    bool compact = false,
    bool minimal = false,
    VoidCallback? onDismiss,
  }) {
    return BlueprintCallout(
      title: title,
      content: content,
      child: child,
      icon: icon,
      intent: BlueprintIntent.primary,
      compact: compact,
      minimal: minimal,
      onDismiss: onDismiss,
    );
  }

  static Widget success({
    String? title,
    String? content,
    Widget? child,
    IconData? icon,
    bool compact = false,
    bool minimal = false,
    VoidCallback? onDismiss,
  }) {
    return BlueprintCallout(
      title: title,
      content: content,
      child: child,
      icon: icon,
      intent: BlueprintIntent.success,
      compact: compact,
      minimal: minimal,
      onDismiss: onDismiss,
    );
  }

  static Widget warning({
    String? title,
    String? content,
    Widget? child,
    IconData? icon,
    bool compact = false,
    bool minimal = false,
    VoidCallback? onDismiss,
  }) {
    return BlueprintCallout(
      title: title,
      content: content,
      child: child,
      icon: icon,
      intent: BlueprintIntent.warning,
      compact: compact,
      minimal: minimal,
      onDismiss: onDismiss,
    );
  }

  static Widget danger({
    String? title,
    String? content,
    Widget? child,
    IconData? icon,
    bool compact = false,
    bool minimal = false,
    VoidCallback? onDismiss,
  }) {
    return BlueprintCallout(
      title: title,
      content: content,
      child: child,
      icon: icon,
      intent: BlueprintIntent.danger,
      compact: compact,
      minimal: minimal,
      onDismiss: onDismiss,
    );
  }

  static Widget basic({
    String? title,
    String? content,
    Widget? child,
    IconData? icon,
    bool compact = false,
    bool minimal = false,
    VoidCallback? onDismiss,
  }) {
    return BlueprintCallout(
      title: title,
      content: content,
      child: child,
      icon: icon,
      intent: BlueprintIntent.none,
      compact: compact,
      minimal: minimal,
      onDismiss: onDismiss,
    );
  }
}