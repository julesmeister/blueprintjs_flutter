import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'blueprint_button.dart';
import 'blueprint_common.dart';
import 'blueprint_dropdown_manager.dart';

class BlueprintSelectOption<T> {
  final T value;
  final String label;
  final IconData? icon;
  final bool disabled;

  const BlueprintSelectOption({
    required this.value,
    required this.label,
    this.icon,
    this.disabled = false,
  });
}

class BlueprintSelect<T> extends StatefulWidget {
  final List<BlueprintSelectOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? placeholder;
  final bool disabled;
  final bool fill;
  final BlueprintIntent intent;
  final IconData? leftIcon;
  final bool filterable;
  final double? width;
  final double? maxHeight;

  const BlueprintSelect({
    super.key,
    required this.options,
    this.value,
    this.onChanged,
    this.placeholder,
    this.disabled = false,
    this.fill = false,
    this.intent = BlueprintIntent.none,
    this.leftIcon,
    this.filterable = false,
    this.width,
    this.maxHeight,
  });

  @override
  State<BlueprintSelect<T>> createState() => _BlueprintSelectState<T>();
}

class _BlueprintSelectState<T> extends State<BlueprintSelect<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  final TextEditingController _filterController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<BlueprintSelectOption<T>> _filteredOptions = [];

  @override
  void initState() {
    super.initState();
    _filteredOptions = widget.options;
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _closeDropdown();
    _filterController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      _closeDropdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    BlueprintSelectOption<T>? selectedOption;
    try {
      selectedOption = widget.options.firstWhere(
        (option) => option.value == widget.value,
      );
    } catch (e) {
      selectedOption = null;
    }

    final hasSelection = widget.value != null && selectedOption != null;
    final displayText = hasSelection ? selectedOption!.label : (widget.placeholder ?? 'Select...');

    Color borderColor;
    if (_isOpen) {
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

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.disabled ? null : _toggleDropdown,
        child: Container(
          width: widget.fill ? double.infinity : widget.width,
          height: BlueprintTheme.buttonHeight,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: _isOpen ? [
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
                    size: 16,
                    color: widget.disabled
                        ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
                        : (isDark ? BlueprintColors.gray1 : BlueprintColors.gray2),
                  ),
                ),
              ],
              if (hasSelection && selectedOption?.icon != null) ...[
                Padding(
                  padding: EdgeInsets.only(
                    left: widget.leftIcon != null ? 0 : 12,
                    right: 8,
                  ),
                  child: Icon(
                    selectedOption!.icon,
                    size: 16,
                    color: isDark ? BlueprintColors.light1 : BlueprintColors.dark1,
                  ),
                ),
              ],
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: (widget.leftIcon != null || (hasSelection && selectedOption?.icon != null)) ? 0 : 12,
                  ),
                  child: Text(
                    displayText,
                    style: TextStyle(
                      fontSize: BlueprintTheme.fontSize,
                      color: hasSelection
                          ? (isDark ? BlueprintColors.light1 : BlueprintColors.dark1)
                          : (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 16,
                  color: isDark ? BlueprintColors.gray1 : BlueprintColors.gray2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    if (_isOpen) return;

    // Register this dropdown with the global manager
    BlueprintDropdownManager().registerDropdown(_closeDropdown);

    setState(() {
      _isOpen = true;
      _filteredOptions = widget.options;
      _filterController.clear();
    });

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeDropdown() {
    if (!_isOpen) return;

    // Unregister this dropdown with the global manager
    BlueprintDropdownManager().unregisterDropdown(_closeDropdown);

    setState(() {
      _isOpen = false;
    });

    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return OverlayEntry(
      builder: (context) => Positioned(
        width: widget.width ?? (widget.fill ? null : 200),
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, BlueprintTheme.buttonHeight + 4),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: widget.maxHeight ?? 200,
              ),
              decoration: BoxDecoration(
                color: isDark ? BlueprintColors.dark3 : BlueprintColors.light5,
                borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
                border: Border.all(
                  color: isDark ? BlueprintColors.dark1 : BlueprintColors.gray5,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.filterable) _buildFilterInput(isDark),
                  Flexible(child: _buildOptionsList(isDark)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterInput(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: _filterController,
        focusNode: _focusNode,
        onChanged: _filterOptions,
        decoration: InputDecoration(
          hintText: 'Filter options...',
          prefixIcon: const Icon(Icons.search, size: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
            borderSide: BorderSide(
              color: isDark ? BlueprintColors.dark1 : BlueprintColors.gray5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        style: TextStyle(
          fontSize: BlueprintTheme.fontSizeSmall,
          color: isDark ? BlueprintColors.light1 : BlueprintColors.dark1,
        ),
      ),
    );
  }

  Widget _buildOptionsList(bool isDark) {
    if (_filteredOptions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'No options found',
          style: TextStyle(
            color: isDark ? BlueprintColors.gray1 : BlueprintColors.gray3,
            fontSize: BlueprintTheme.fontSizeSmall,
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _filteredOptions.length,
      itemBuilder: (context, index) {
        final option = _filteredOptions[index];
        final isSelected = option.value == widget.value;
        
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: option.disabled ? null : () => _selectOption(option),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  if (option.icon != null) ...[
                    Icon(
                      option.icon,
                      size: 16,
                      color: option.disabled
                          ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
                          : (isDark ? BlueprintColors.light1 : BlueprintColors.dark1),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      option.label,
                      style: TextStyle(
                        fontSize: BlueprintTheme.fontSize,
                        color: option.disabled
                            ? (isDark ? BlueprintColors.gray1 : BlueprintColors.gray3)
                            : (isDark ? BlueprintColors.light1 : BlueprintColors.dark1),
                        fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check,
                      size: 16,
                      color: BlueprintColors.blue3,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _filterOptions(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredOptions = widget.options;
      } else {
        _filteredOptions = widget.options
            .where((option) => 
                option.label.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _selectOption(BlueprintSelectOption<T> option) {
    widget.onChanged?.call(option.value);
    _closeDropdown();
  }
}

class BlueprintSelects {
  static BlueprintSelect<T> simple<T>({
    required List<BlueprintSelectOption<T>> options,
    T? value,
    ValueChanged<T?>? onChanged,
    String? placeholder,
    bool fill = false,
  }) {
    return BlueprintSelect<T>(
      options: options,
      value: value,
      onChanged: onChanged,
      placeholder: placeholder,
      fill: fill,
    );
  }

  static BlueprintSelect<T> filterable<T>({
    required List<BlueprintSelectOption<T>> options,
    T? value,
    ValueChanged<T?>? onChanged,
    String? placeholder,
    bool fill = false,
  }) {
    return BlueprintSelect<T>(
      options: options,
      value: value,
      onChanged: onChanged,
      placeholder: placeholder,
      filterable: true,
      fill: fill,
    );
  }

  static BlueprintSelect<T> withIntent<T>({
    required List<BlueprintSelectOption<T>> options,
    required BlueprintIntent intent,
    T? value,
    ValueChanged<T?>? onChanged,
    String? placeholder,
    bool fill = false,
  }) {
    return BlueprintSelect<T>(
      options: options,
      value: value,
      onChanged: onChanged,
      placeholder: placeholder,
      intent: intent,
      fill: fill,
    );
  }
}