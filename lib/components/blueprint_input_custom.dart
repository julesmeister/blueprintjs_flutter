import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'blueprint_common.dart';

enum BlueprintInputSize {
  small,
  regular,
  large,
}

class BlueprintInputGroupCustom extends StatefulWidget {
  final String? placeholder;
  final String? value;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSubmitted;
  final IconData? leftIcon;
  final Widget? rightElement;
  final BlueprintIntent intent;
  final BlueprintInputSize size;
  final bool disabled;
  final bool fill;
  final bool round;
  final TextInputType keyboardType;
  final bool obscureText;
  final int? maxLines;
  final String? helperText;
  final String? errorText;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const BlueprintInputGroupCustom({
    super.key,
    this.placeholder,
    this.value,
    this.onChanged,
    this.onSubmitted,
    this.leftIcon,
    this.rightElement,
    this.intent = BlueprintIntent.none,
    this.size = BlueprintInputSize.regular,
    this.disabled = false,
    this.fill = false,
    this.round = false,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.helperText,
    this.errorText,
    this.focusNode,
    this.controller,
  });

  @override
  State<BlueprintInputGroupCustom> createState() => _BlueprintInputGroupCustomState();
}

class _BlueprintInputGroupCustomState extends State<BlueprintInputGroupCustom> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.value);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  double get _inputHeight {
    switch (widget.size) {
      case BlueprintInputSize.small:
        return BlueprintTheme.buttonHeightSmall;
      case BlueprintInputSize.regular:
        return BlueprintTheme.buttonHeight;
      case BlueprintInputSize.large:
        return BlueprintTheme.buttonHeightLarge;
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case BlueprintInputSize.small:
        return BlueprintTheme.fontSizeSmall;
      case BlueprintInputSize.regular:
        return BlueprintTheme.fontSize;
      case BlueprintInputSize.large:
        return BlueprintTheme.fontSizeLarge;
    }
  }

  double get _iconSize {
    switch (widget.size) {
      case BlueprintInputSize.small:
        return 14;
      case BlueprintInputSize.regular:
        return 16;
      case BlueprintInputSize.large:
        return 18;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasError = widget.errorText != null;
    final isMultiLine = widget.maxLines != null && widget.maxLines! > 1;
    
    Color borderColor;
    if (hasError) {
      borderColor = BlueprintColors.red3;
    } else if (_isFocused) {
      switch (widget.intent) {
        case BlueprintIntent.primary:
          borderColor = BlueprintColors.blue3;
          break;
        case BlueprintIntent.success:
          borderColor = BlueprintColors.green3;
          break;
        case BlueprintIntent.warning:
          borderColor = BlueprintColors.orange3;
          break;
        case BlueprintIntent.danger:
          borderColor = BlueprintColors.red3;
          break;
        case BlueprintIntent.none:
          borderColor = BlueprintColors.blue3;
          break;
      }
    } else {
      borderColor = isDark ? BlueprintColors.dark1 : BlueprintColors.gray5;
    }

    final backgroundColor = widget.disabled
        ? (isDark ? BlueprintColors.dark2 : BlueprintColors.light4)
        : (isDark ? BlueprintColors.dark3 : BlueprintColors.light5);

    final textColor = widget.disabled
        ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
        : (isDark ? BlueprintColors.light1 : BlueprintColors.dark1);

    final placeholderColor = isDark ? BlueprintColors.gray1 : BlueprintColors.gray3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: widget.fill ? double.infinity : null,
          height: isMultiLine ? null : _inputHeight,
          constraints: isMultiLine 
              ? BoxConstraints(minHeight: _inputHeight * 2)
              : null,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(
              widget.round ? _inputHeight / 2 : BlueprintTheme.borderRadius,
            ),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: _isFocused && !hasError ? [
              BoxShadow(
                color: borderColor.withValues(alpha: 0.3),
                offset: const Offset(0, 0),
                blurRadius: 0,
                spreadRadius: 1,
              ),
            ] : null,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Show placeholder when field is empty
              if (_controller.text.isEmpty && widget.placeholder != null)
                Positioned.fill(
                  child: Row(
                    children: [
                      if (widget.leftIcon != null) ...[
                        SizedBox(
                          width: _inputHeight,
                          child: Center(
                            child: Icon(
                              widget.leftIcon,
                              size: _iconSize,
                              color: widget.disabled
                                  ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
                                  : (isDark ? BlueprintColors.gray1 : BlueprintColors.gray2),
                            ),
                          ),
                        ),
                      ] else ...[
                        const SizedBox(width: 12),
                      ],
                      Text(
                        widget.placeholder!,
                        style: TextStyle(
                          fontSize: _fontSize,
                          color: placeholderColor,
                        ),
                      ),
                    ],
                  ),
                ),
              // Actual input field
              Row(
                children: [
                  if (widget.leftIcon != null) ...[
                    SizedBox(
                      width: _inputHeight,
                      child: Center(
                        child: Icon(
                          widget.leftIcon,
                          size: _iconSize,
                          color: widget.disabled
                              ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
                              : (isDark ? BlueprintColors.gray1 : BlueprintColors.gray2),
                        ),
                      ),
                    ),
                  ],
                  Expanded(
                    child: EditableText(
                      controller: _controller,
                      focusNode: _focusNode,
                      style: TextStyle(
                        fontSize: _fontSize,
                        color: textColor,
                      ),
                      cursorColor: textColor,
                      backgroundCursorColor: Colors.grey,
                      keyboardType: widget.keyboardType,
                      obscureText: widget.obscureText,
                      maxLines: widget.maxLines ?? 1,
                      onChanged: (text) {
                        setState(() {}); // Update to show/hide placeholder
                        widget.onChanged?.call(text);
                      },
                      onSubmitted: (_) => widget.onSubmitted?.call(),
                      textAlign: TextAlign.start,
                      textAlignVertical: isMultiLine ? TextAlignVertical.top : TextAlignVertical.center,
                      // Padding for the text
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.leftIcon != null ? 0 : 12,
                        vertical: isMultiLine ? 10 : 0,
                      ),
                    ),
                  ),
                  if (widget.rightElement != null) ...[
                    Container(
                      padding: const EdgeInsets.only(right: 8),
                      height: _inputHeight,
                      child: Center(
                        child: widget.rightElement!,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        if (widget.helperText != null || widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              widget.errorText ?? widget.helperText!,
              style: TextStyle(
                fontSize: BlueprintTheme.fontSizeSmall,
                color: hasError
                    ? BlueprintColors.red3
                    : (isDark ? BlueprintColors.gray1 : BlueprintColors.gray2),
              ),
            ),
          ),
      ],
    );
  }
}