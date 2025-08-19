import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'blueprint_button.dart';
import 'blueprint_common.dart';

enum BlueprintInputSize {
  small,
  regular,
  large,
}

class BlueprintInputGroup extends StatefulWidget {
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

  const BlueprintInputGroup({
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
  State<BlueprintInputGroup> createState() => _BlueprintInputGroupState();
}

class _BlueprintInputGroupState extends State<BlueprintInputGroup> {
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(isDark),
        if (widget.helperText != null || widget.errorText != null)
          _buildHelperText(isDark),
      ],
    );
  }

  Widget _buildInputField(bool isDark) {
    final inputHeight = _getInputHeight();
    final hasError = widget.errorText != null;
    
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

    return Container(
      width: widget.fill ? double.infinity : null,
      height: inputHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          widget.round ? inputHeight / 2 : BlueprintTheme.borderRadius,
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
      child: Row(
        children: [
          if (widget.leftIcon != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Icon(
                widget.leftIcon,
                size: _getIconSize(),
                color: widget.disabled
                    ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
                    : (isDark ? BlueprintColors.gray1 : BlueprintColors.gray2),
              ),
            ),
          ],
          Expanded(
            child: Center(
              child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: !widget.disabled,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted != null 
                  ? (_) => widget.onSubmitted!()
                  : null,
              style: TextStyle(
                fontSize: _getFontSize(),
                color: widget.disabled
                    ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
                    : (isDark ? BlueprintColors.light1 : BlueprintColors.dark1),
              ),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: TextStyle(
                  fontSize: _getFontSize(),
                  color: isDark ? BlueprintColors.gray1 : BlueprintColors.gray3,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: widget.leftIcon != null ? 0 : 12,
                  vertical: (_getInputHeight() - _getFontSize() * 1.2) / 2,
                ),
                isDense: true,
              ),
            ),
            ),
          ),
          if (widget.rightElement != null) ...[
            Container(
              padding: const EdgeInsets.only(right: 8),
              height: inputHeight,
              child: Center(
                child: widget.rightElement!,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHelperText(bool isDark) {
    final text = widget.errorText ?? widget.helperText!;
    final isError = widget.errorText != null;
    
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: BlueprintTheme.fontSizeSmall,
          color: isError
              ? BlueprintColors.red3
              : (isDark ? BlueprintColors.gray1 : BlueprintColors.gray2),
        ),
      ),
    );
  }

  double _getInputHeight() {
    switch (widget.size) {
      case BlueprintInputSize.small:
        return BlueprintTheme.buttonHeightSmall;
      case BlueprintInputSize.regular:
        return BlueprintTheme.buttonHeight;
      case BlueprintInputSize.large:
        return BlueprintTheme.buttonHeightLarge;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case BlueprintInputSize.small:
        return BlueprintTheme.fontSizeSmall;
      case BlueprintInputSize.regular:
        return BlueprintTheme.fontSize;
      case BlueprintInputSize.large:
        return BlueprintTheme.fontSizeLarge;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case BlueprintInputSize.small:
        return 14;
      case BlueprintInputSize.regular:
        return 16;
      case BlueprintInputSize.large:
        return 18;
    }
  }
}

class BlueprintInputs {
  static BlueprintInputGroup standard({
    String? placeholder,
    String? value,
    ValueChanged<String>? onChanged,
    IconData? leftIcon,
    bool fill = false,
  }) {
    return BlueprintInputGroup(
      placeholder: placeholder,
      value: value,
      onChanged: onChanged,
      leftIcon: leftIcon,
      fill: fill,
    );
  }

  static BlueprintInputGroup search({
    String? placeholder = 'Search...',
    String? value,
    ValueChanged<String>? onChanged,
    bool fill = false,
  }) {
    return BlueprintInputGroup(
      placeholder: placeholder,
      value: value,
      onChanged: onChanged,
      leftIcon: Icons.search,
      round: true,
      fill: fill,
      keyboardType: TextInputType.text,
    );
  }

  static Widget password({
    String? placeholder = 'Password',
    String? value,
    ValueChanged<String>? onChanged,
    bool fill = false,
  }) {
    return _PasswordInput(
      placeholder: placeholder,
      value: value,
      onChanged: onChanged,
      fill: fill,
    );
  }

  static BlueprintInputGroup withIntent({
    required BlueprintIntent intent,
    String? placeholder,
    String? value,
    ValueChanged<String>? onChanged,
    IconData? leftIcon,
    bool fill = false,
  }) {
    return BlueprintInputGroup(
      placeholder: placeholder,
      value: value,
      onChanged: onChanged,
      leftIcon: leftIcon,
      intent: intent,
      fill: fill,
    );
  }
}

class _PasswordInput extends StatefulWidget {
  final String? placeholder;
  final String? value;
  final ValueChanged<String>? onChanged;
  final bool fill;

  const _PasswordInput({
    this.placeholder,
    this.value,
    this.onChanged,
    this.fill = false,
  });

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlueprintInputGroup(
      placeholder: widget.placeholder,
      value: widget.value,
      onChanged: widget.onChanged,
      leftIcon: Icons.lock_outline,
      obscureText: _obscureText,
      fill: widget.fill,
      rightElement: SizedBox(
        width: 24,
        height: 24,
        child: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            size: 16,
          ),
          onPressed: () => setState(() => _obscureText = !_obscureText),
          tooltip: _obscureText ? 'Show password' : 'Hide password',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
    );
  }
}