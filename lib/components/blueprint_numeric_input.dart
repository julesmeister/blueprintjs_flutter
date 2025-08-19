import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'blueprint_button.dart';
import 'blueprint_input.dart';
import 'blueprint_common.dart';

class BlueprintNumericInput extends StatefulWidget {
  final double? value;
  final ValueChanged<double?>? onValueChange;
  final double? min;
  final double? max;
  final double stepSize;
  final String? placeholder;
  final bool disabled;
  final bool fill;
  final BlueprintIntent intent;
  final IconData? leftIcon;
  final Widget? leftElement;
  final String buttonPosition; // "left", "right", or "none"
  final bool allowNumericCharactersOnly;
  final bool selectAllOnFocus;
  final bool selectAllOnIncrement;
  final BlueprintButtonSize size;

  const BlueprintNumericInput({
    super.key,
    this.value,
    this.onValueChange,
    this.min,
    this.max,
    this.stepSize = 1,
    this.placeholder,
    this.disabled = false,
    this.fill = false,
    this.intent = BlueprintIntent.none,
    this.leftIcon,
    this.leftElement,
    this.buttonPosition = "right",
    this.allowNumericCharactersOnly = true,
    this.selectAllOnFocus = false,
    this.selectAllOnIncrement = false,
    this.size = BlueprintButtonSize.medium,
  });

  @override
  State<BlueprintNumericInput> createState() => _BlueprintNumericInputState();
}

class _BlueprintNumericInputState extends State<BlueprintNumericInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.value?.toString() ?? '',
    );
    _focusNode = FocusNode();
    
    if (widget.selectAllOnFocus) {
      _focusNode.addListener(_handleFocusChange);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus && widget.selectAllOnFocus) {
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    }
  }

  @override
  void didUpdateWidget(BlueprintNumericInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.text = widget.value?.toString() ?? '';
    }
  }

  void _handleIncrement() {
    final currentValue = widget.value ?? 0;
    final newValue = currentValue + widget.stepSize;
    final clampedValue = widget.max != null 
        ? newValue.clamp(widget.min ?? double.negativeInfinity, widget.max!)
        : (widget.min != null ? newValue.clamp(widget.min!, double.infinity) : newValue);
    
    if (widget.selectAllOnIncrement) {
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    }
    
    widget.onValueChange?.call(clampedValue);
  }

  void _handleDecrement() {
    final currentValue = widget.value ?? 0;
    final newValue = currentValue - widget.stepSize;
    final clampedValue = widget.min != null 
        ? newValue.clamp(widget.min!, widget.max ?? double.infinity)
        : (widget.max != null ? newValue.clamp(double.negativeInfinity, widget.max!) : newValue);
    
    if (widget.selectAllOnIncrement) {
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    }
    
    widget.onValueChange?.call(clampedValue);
  }

  void _handleTextChanged(String value) {
    if (value.isEmpty) {
      widget.onValueChange?.call(null);
      return;
    }
    
    final parsed = double.tryParse(value);
    if (parsed != null) {
      widget.onValueChange?.call(parsed);
    }
  }

  Widget _buildIncrementButton() {
    return SizedBox(
      width: _getButtonWidth(),
      height: _getButtonHeight() / 2,
      child: BlueprintButton(
        icon: Icons.keyboard_arrow_up,
        onPressed: widget.disabled ? null : _handleIncrement,
        size: BlueprintButtonSize.small,
        variant: BlueprintButtonVariant.minimal,
        intent: widget.intent,
      ),
    );
  }

  Widget _buildDecrementButton() {
    return SizedBox(
      width: _getButtonWidth(),
      height: _getButtonHeight() / 2,
      child: BlueprintButton(
        icon: Icons.keyboard_arrow_down,
        onPressed: widget.disabled ? null : _handleDecrement,
        size: BlueprintButtonSize.small,
        variant: BlueprintButtonVariant.minimal,
        intent: widget.intent,
      ),
    );
  }

  double _getButtonWidth() {
    switch (widget.size) {
      case BlueprintButtonSize.large:
        return BlueprintTheme.buttonHeightLarge;
      case BlueprintButtonSize.small:
        return BlueprintTheme.buttonHeightSmall;
      default:
        return BlueprintTheme.buttonHeight;
    }
  }

  double _getButtonHeight() {
    switch (widget.size) {
      case BlueprintButtonSize.large:
        return BlueprintTheme.buttonHeightLarge;
      case BlueprintButtonSize.small:
        return BlueprintTheme.buttonHeightSmall;
      default:
        return BlueprintTheme.buttonHeight;
    }
  }

  Widget _buildButtons() {
    if (widget.buttonPosition == "none") {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: widget.buttonPosition == "right" 
              ? BorderSide(color: Theme.of(context).brightness == Brightness.dark 
                  ? BlueprintColors.dark1 : BlueprintColors.gray5, width: 1)
              : BorderSide.none,
          right: widget.buttonPosition == "left"
              ? BorderSide(color: Theme.of(context).brightness == Brightness.dark 
                  ? BlueprintColors.dark1 : BlueprintColors.gray5, width: 1)
              : BorderSide.none,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIncrementButton(),
          Container(
            height: 1,
            width: _getButtonWidth(),
            color: Theme.of(context).brightness == Brightness.dark 
                ? BlueprintColors.dark1 : BlueprintColors.gray5,
          ),
          _buildDecrementButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final input = BlueprintInputGroup(
      controller: _controller,
      focusNode: _focusNode,
      placeholder: widget.placeholder ?? "Enter a number...",
      disabled: widget.disabled,
      fill: widget.fill,
      intent: widget.intent,
      leftIcon: widget.leftIcon,
      leftElement: widget.leftElement,
      size: widget.size,
      keyboardType: TextInputType.numberWithOptions(
        decimal: widget.stepSize != widget.stepSize.round(),
        signed: widget.min == null || widget.min! < 0,
      ),
      inputFormatters: widget.allowNumericCharactersOnly 
          ? [FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]*\.?[0-9]*'))]
          : null,
      onChanged: _handleTextChanged,
    );

    if (widget.buttonPosition == "none") {
      return input;
    }

    return Row(
      mainAxisSize: widget.fill ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (widget.buttonPosition == "left") _buildButtons(),
        Expanded(
          flex: widget.fill ? 1 : 0,
          child: input,
        ),
        if (widget.buttonPosition == "right") _buildButtons(),
      ],
    );
  }
}

class BlueprintNumericInputs {
  static BlueprintNumericInput simple({
    double? value,
    ValueChanged<double?>? onValueChange,
    String? placeholder,
    bool fill = false,
  }) {
    return BlueprintNumericInput(
      value: value,
      onValueChange: onValueChange,
      placeholder: placeholder,
      fill: fill,
    );
  }

  static BlueprintNumericInput withRange({
    required double min,
    required double max,
    double? value,
    ValueChanged<double?>? onValueChange,
    double stepSize = 1,
    String? placeholder,
    bool fill = false,
  }) {
    return BlueprintNumericInput(
      value: value,
      onValueChange: onValueChange,
      min: min,
      max: max,
      stepSize: stepSize,
      placeholder: placeholder,
      fill: fill,
    );
  }

  static BlueprintNumericInput withIntent({
    required BlueprintIntent intent,
    double? value,
    ValueChanged<double?>? onValueChange,
    String? placeholder,
    bool fill = false,
  }) {
    return BlueprintNumericInput(
      value: value,
      onValueChange: onValueChange,
      intent: intent,
      placeholder: placeholder,
      fill: fill,
    );
  }

  static BlueprintNumericInput large({
    double? value,
    ValueChanged<double?>? onValueChange,
    String? placeholder,
    bool fill = false,
  }) {
    return BlueprintNumericInput(
      value: value,
      onValueChange: onValueChange,
      placeholder: placeholder,
      fill: fill,
      size: BlueprintButtonSize.large,
    );
  }

  static BlueprintNumericInput small({
    double? value,
    ValueChanged<double?>? onValueChange,
    String? placeholder,
    bool fill = false,
  }) {
    return BlueprintNumericInput(
      value: value,
      onValueChange: onValueChange,
      placeholder: placeholder,
      fill: fill,
      size: BlueprintButtonSize.small,
    );
  }
}