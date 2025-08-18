import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';

class BlueprintDialog extends StatelessWidget {
  final Widget? title;
  final Widget? icon;
  final Widget body;
  final List<Widget>? actions;
  final bool canEscapeKeyClose;
  final bool canOutsideClickClose;
  final bool isCloseButtonShown;
  final VoidCallback? onClose;
  final double? width;
  final double? height;

  const BlueprintDialog({
    Key? key,
    this.title,
    this.icon,
    required this.body,
    this.actions,
    this.canEscapeKeyClose = true,
    this.canOutsideClickClose = true,
    this.isCloseButtonShown = true,
    this.onClose,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: BlueprintTheme.gridSize * 2,
        vertical: BlueprintTheme.gridSize * 3,
      ),
      child: GestureDetector(
        onTap: canOutsideClickClose ? () => _handleClose(context) : null,
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: GestureDetector(
              onTap: () {}, // Prevent close when tapping dialog content
              child: Container(
                width: width ?? BlueprintTheme.gridSize * 50,
                height: height,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - (BlueprintTheme.gridSize * 4),
                  maxHeight: MediaQuery.of(context).size.height - (BlueprintTheme.gridSize * 6),
                ),
                decoration: BoxDecoration(
                  color: BlueprintColors.lightGray5,
                  borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius * 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 8),
                      blurRadius: 24,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title != null || isCloseButtonShown)
                      _buildHeader(context),
                    Flexible(
                      child: _buildBody(),
                    ),
                    if (actions != null && actions!.isNotEmpty)
                      _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(BlueprintTheme.borderRadius * 2),
          topRight: Radius.circular(BlueprintTheme.borderRadius * 2),
        ),
        boxShadow: const [
          BoxShadow(
            color: BlueprintColors.dividerBlack,
            offset: Offset(0, 1),
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(BlueprintTheme.gridSize * 0.5),
        child: Row(
          children: [
            if (icon != null) ...[
              Padding(
                padding: EdgeInsets.only(
                  left: BlueprintTheme.gridSize * 0.5,
                  right: BlueprintTheme.gridSize * 0.75,
                ),
                child: IconTheme(
                  data: const IconThemeData(
                    color: BlueprintColors.textColor,
                    size: 20,
                  ),
                  child: icon!,
                ),
              ),
            ] else ...[
              SizedBox(width: BlueprintTheme.gridSize * 1.5),
            ],
            if (title != null)
              Expanded(
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: BlueprintColors.headingColor,
                    fontSize: BlueprintTheme.fontSize,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                  ),
                  child: title!,
                ),
              ),
            if (isCloseButtonShown)
              IconButton(
                icon: const Icon(Icons.close),
                iconSize: 16,
                color: BlueprintColors.textColorMuted,
                padding: EdgeInsets.all(BlueprintTheme.gridSize * 0.5),
                constraints: BoxConstraints(
                  minWidth: BlueprintTheme.buttonHeight,
                  minHeight: BlueprintTheme.buttonHeight,
                ),
                onPressed: () => _handleClose(context),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(BlueprintTheme.gridSize * 1.5),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: BlueprintColors.textColor,
          fontSize: BlueprintTheme.fontSize,
        ),
        child: body,
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(BlueprintTheme.gridSize * 1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          for (int i = 0; i < actions!.length; i++) ...[
            if (i > 0) SizedBox(width: BlueprintTheme.gridSize),
            actions![i],
          ],
        ],
      ),
    );
  }

  void _handleClose(BuildContext context) {
    if (onClose != null) {
      onClose!();
    } else {
      Navigator.of(context).pop();
    }
  }

  static Future<T?> show<T>({
    required BuildContext context,
    Widget? title,
    Widget? icon,
    required Widget body,
    List<Widget>? actions,
    bool canEscapeKeyClose = true,
    bool canOutsideClickClose = true,
    bool isCloseButtonShown = true,
    VoidCallback? onClose,
    double? width,
    double? height,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: canOutsideClickClose,
      builder: (context) => BlueprintDialog(
        title: title,
        icon: icon,
        body: body,
        actions: actions,
        canEscapeKeyClose: canEscapeKeyClose,
        canOutsideClickClose: canOutsideClickClose,
        isCloseButtonShown: isCloseButtonShown,
        onClose: onClose,
        width: width,
        height: height,
      ),
    );
  }
}

// Factory methods for common dialog types
class BlueprintDialogs {
  static Future<T?> alert<T>({
    required BuildContext context,
    Widget? icon,
    required String title,
    required String message,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
  }) {
    return BlueprintDialog.show<T>(
      context: context,
      title: Text(title),
      icon: icon,
      body: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onConfirm != null) onConfirm();
          },
          child: Text(confirmText),
        ),
      ],
    );
  }

  static Future<bool?> confirm({
    required BuildContext context,
    Widget? icon,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return BlueprintDialog.show<bool>(
      context: context,
      title: Text(title),
      icon: icon,
      body: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
            if (onCancel != null) onCancel();
          },
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            if (onConfirm != null) onConfirm();
          },
          child: Text(confirmText),
        ),
      ],
    );
  }

  static Future<String?> prompt({
    required BuildContext context,
    Widget? icon,
    required String title,
    String? message,
    String? defaultValue,
    String? placeholder,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
  }) {
    final controller = TextEditingController(text: defaultValue);
    
    return BlueprintDialog.show<String>(
      context: context,
      title: Text(title),
      icon: icon,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message != null) ...[
            Text(message),
            SizedBox(height: BlueprintTheme.gridSize),
          ],
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: placeholder,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(controller.text),
          child: Text(confirmText),
        ),
      ],
    );
  }
}