import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';

class BlueprintCollapse extends StatefulWidget {
  final Widget child;
  final bool isOpen;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onToggle;

  const BlueprintCollapse({
    Key? key,
    required this.child,
    this.isOpen = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.onToggle,
  }) : super(key: key);

  @override
  State<BlueprintCollapse> createState() => _BlueprintCollapseState();
}

class _BlueprintCollapseState extends State<BlueprintCollapse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    if (widget.isOpen) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(BlueprintCollapse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isOpen != widget.isOpen) {
      if (widget.isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: widget.child,
    );
  }
}

class BlueprintCollapsePanel extends StatefulWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget child;
  final bool initiallyOpen;
  final bool disabled;
  final IconData? icon;
  final IconData? openIcon;
  final IconData? closedIcon;
  final VoidCallback? onToggle;

  const BlueprintCollapsePanel({
    Key? key,
    this.title,
    this.titleWidget,
    required this.child,
    this.initiallyOpen = false,
    this.disabled = false,
    this.icon,
    this.openIcon,
    this.closedIcon,
    this.onToggle,
  }) : super(key: key);

  @override
  State<BlueprintCollapsePanel> createState() => _BlueprintCollapsePanelState();
}

class _BlueprintCollapsePanelState extends State<BlueprintCollapsePanel> {
  late bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = widget.initiallyOpen;
  }

  void _toggle() {
    if (widget.disabled) return;
    
    setState(() {
      _isOpen = !_isOpen;
    });
    
    if (widget.onToggle != null) {
      widget.onToggle!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        BlueprintCollapse(
          isOpen: _isOpen,
          child: widget.child,
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _toggle,
        child: Container(
          padding: EdgeInsets.all(BlueprintTheme.gridSize),
          child: Row(
            children: [
              // Expand/Collapse icon
              AnimatedRotation(
                turns: _isOpen ? 0.25 : 0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: widget.disabled 
                      ? BlueprintColors.textColorDisabled
                      : BlueprintColors.textColorMuted,
                ),
              ),
              
              const SizedBox(width: BlueprintTheme.gridSize * 0.5),
              
              // Optional leading icon
              if (widget.icon != null || 
                  widget.openIcon != null || 
                  widget.closedIcon != null) ...[
                Icon(
                  _getLeadingIcon(),
                  size: 16,
                  color: widget.disabled 
                      ? BlueprintColors.textColorDisabled
                      : BlueprintColors.textColor,
                ),
                const SizedBox(width: BlueprintTheme.gridSize * 0.5),
              ],
              
              // Title
              Expanded(
                child: widget.titleWidget ?? Text(
                  widget.title ?? '',
                  style: TextStyle(
                    color: widget.disabled 
                        ? BlueprintColors.textColorDisabled
                        : BlueprintColors.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: BlueprintTheme.fontSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getLeadingIcon() {
    if (widget.openIcon != null && widget.closedIcon != null) {
      return _isOpen ? widget.openIcon! : widget.closedIcon!;
    }
    return widget.icon ?? Icons.folder;
  }
}

// Factory methods for common collapse patterns
class BlueprintCollapses {
  static Widget simple({
    required Widget child,
    bool isOpen = false,
    VoidCallback? onToggle,
  }) {
    return BlueprintCollapse(
      isOpen: isOpen,
      onToggle: onToggle,
      child: child,
    );
  }

  static Widget panel({
    required String title,
    required Widget child,
    bool initiallyOpen = false,
    bool disabled = false,
    IconData? icon,
    VoidCallback? onToggle,
  }) {
    return BlueprintCollapsePanel(
      title: title,
      child: child,
      initiallyOpen: initiallyOpen,
      disabled: disabled,
      icon: icon,
      onToggle: onToggle,
    );
  }

  static Widget withCustomHeader({
    required Widget titleWidget,
    required Widget child,
    bool initiallyOpen = false,
    bool disabled = false,
    VoidCallback? onToggle,
  }) {
    return BlueprintCollapsePanel(
      titleWidget: titleWidget,
      child: child,
      initiallyOpen: initiallyOpen,
      disabled: disabled,
      onToggle: onToggle,
    );
  }

  static Widget folder({
    required String title,
    required Widget child,
    bool initiallyOpen = false,
    bool disabled = false,
    VoidCallback? onToggle,
  }) {
    return BlueprintCollapsePanel(
      title: title,
      child: child,
      initiallyOpen: initiallyOpen,
      disabled: disabled,
      openIcon: Icons.folder_open,
      closedIcon: Icons.folder,
      onToggle: onToggle,
    );
  }
}