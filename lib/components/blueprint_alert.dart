import 'package:flutter/material.dart';
import 'blueprint_common.dart';
import 'blueprint_button.dart';

class BlueprintAlert extends StatelessWidget {
  final String? title;
  final Widget? content;
  final String? confirmText;
  final String? cancelText;
  final BlueprintIntent intent;
  final IconData? icon;
  final bool loading;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Function(bool confirmed)? onClose;

  const BlueprintAlert({
    super.key,
    this.title,
    this.content,
    this.confirmText = 'OK',
    this.cancelText,
    this.intent = BlueprintIntent.none,
    this.icon,
    this.loading = false,
    this.onConfirm,
    this.onCancel,
    this.onClose,
  });

  Color _getIntentColor() {
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
        return BlueprintColors.gray3;
    }
  }

  void _handleConfirm() {
    if (onConfirm != null) onConfirm!();
    if (onClose != null) onClose!(true);
  }

  void _handleCancel() {
    if (onCancel != null) onCancel!();
    if (onClose != null) onClose!(false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: BlueprintColors.appSecondaryBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius * 2),
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
      actionsPadding: const EdgeInsets.fromLTRB(
        BlueprintTheme.gridSize * 2,
        0,
        BlueprintTheme.gridSize * 2,
        BlueprintTheme.gridSize * 2,
      ),
      title: null,
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 40,
              color: _getIntentColor(),
            ),
            const SizedBox(width: BlueprintTheme.gridSize),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: const TextStyle(
                      fontSize: BlueprintTheme.fontSizeLarge,
                      fontWeight: FontWeight.w600,
                      color: BlueprintColors.headingColor,
                    ),
                  ),
                if (title != null && content != null)
                  const SizedBox(height: BlueprintTheme.gridSize),
                if (content != null) content!,
              ],
            ),
          ),
        ],
      ),
      actions: [
        if (cancelText != null)
          BlueprintButton(
            text: cancelText!,
            disabled: loading,
            onPressed: _handleCancel,
          ),
        const SizedBox(width: BlueprintTheme.gridSize),
        BlueprintButton(
          text: confirmText ?? 'OK',
          intent: intent,
          loading: loading,
          onPressed: _handleConfirm,
        ),
      ],
    );
  }
}

// Alert helper functions
class BlueprintAlertHelper {
  static Future<bool?> show({
    required BuildContext context,
    String? title,
    Widget? content,
    String? confirmText = 'OK',
    String? cancelText,
    BlueprintIntent intent = BlueprintIntent.none,
    IconData? icon,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => BlueprintAlert(
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        intent: intent,
        icon: icon,
        onClose: (confirmed) => Navigator.of(context).pop(confirmed),
      ),
    );
  }

  static Future<bool?> showConfirm({
    required BuildContext context,
    String? title,
    Widget? content,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    BlueprintIntent intent = BlueprintIntent.primary,
  }) {
    return show(
      context: context,
      title: title,
      content: content,
      confirmText: confirmText,
      cancelText: cancelText,
      intent: intent,
      icon: Icons.help_outline,
    );
  }

  static Future<void> showInfo({
    required BuildContext context,
    String? title,
    Widget? content,
    String confirmText = 'OK',
  }) {
    return show(
      context: context,
      title: title,
      content: content,
      confirmText: confirmText,
      intent: BlueprintIntent.primary,
      icon: Icons.info_outline,
    );
  }

  static Future<void> showWarning({
    required BuildContext context,
    String? title,
    Widget? content,
    String confirmText = 'OK',
  }) {
    return show(
      context: context,
      title: title,
      content: content,
      confirmText: confirmText,
      intent: BlueprintIntent.warning,
      icon: Icons.warning_amber_outlined,
    );
  }

  static Future<void> showError({
    required BuildContext context,
    String? title,
    Widget? content,
    String confirmText = 'OK',
  }) {
    return show(
      context: context,
      title: title,
      content: content,
      confirmText: confirmText,
      intent: BlueprintIntent.danger,
      icon: Icons.error_outline,
    );
  }

  static Future<void> showSuccess({
    required BuildContext context,
    String? title,
    Widget? content,
    String confirmText = 'OK',
  }) {
    return show(
      context: context,
      title: title,
      content: content,
      confirmText: confirmText,
      intent: BlueprintIntent.success,
      icon: Icons.check_circle_outline,
    );
  }
}