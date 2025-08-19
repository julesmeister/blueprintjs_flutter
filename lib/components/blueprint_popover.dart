import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'popover_models.dart';
import 'popover_content.dart';
import 'blueprint_button.dart';
import 'blueprint_common.dart';

// Re-export for convenience
export 'popover_models.dart';
export 'blueprint_button.dart' show BlueprintIntent, BlueprintButtonVariant;

class BlueprintPopover extends StatefulWidget {
  final Widget child;
  final Widget content;
  final BlueprintPopoverPosition position;
  final BlueprintPopoverInteraction interaction;
  final bool usePortal;
  final bool canEscapeKeyClose;
  final bool minimal;
  final bool disabled;
  final double? maxWidth;
  final double? maxHeight;
  final Duration hoverOpenDelay;
  final Duration hoverCloseDelay;
  final VoidCallback? onOpening;
  final VoidCallback? onOpened;
  final VoidCallback? onClosing;
  final VoidCallback? onClosed;
  final bool? isOpen;
  final VoidCallback? onInteraction;

  const BlueprintPopover({
    Key? key,
    required this.child,
    required this.content,
    this.position = BlueprintPopoverPosition.bottom,
    this.interaction = BlueprintPopoverInteraction.click,
    this.usePortal = true,
    this.canEscapeKeyClose = true,
    this.minimal = false,
    this.disabled = false,
    this.maxWidth,
    this.maxHeight,
    this.hoverOpenDelay = const Duration(milliseconds: 100),
    this.hoverCloseDelay = const Duration(milliseconds: 300),
    this.onOpening,
    this.onOpened,
    this.onClosing,
    this.onClosed,
    this.isOpen,
    this.onInteraction,
  }) : super(key: key);

  @override
  State<BlueprintPopover> createState() => _BlueprintPopoverState();
}

class _BlueprintPopoverState extends State<BlueprintPopover>
    with TickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isOpen = false;
  bool _isHovering = false;
  bool _isHoveringPopover = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();

    if (widget.isOpen == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _openPopover());
    }
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void didUpdateWidget(BlueprintPopover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      if (widget.isOpen == true && !_isOpen) {
        _openPopover();
      } else if (widget.isOpen == false && _isOpen) {
        _closePopover();
      }
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _animationController.dispose();
    super.dispose();
  }

  void _openPopover() {
    if (widget.disabled || _isOpen) return;

    widget.onOpening?.call();
    widget.onInteraction?.call();
    
    setState(() => _isOpen = true);
    
    if (widget.usePortal) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
    
    _animationController.forward().then((_) {
      widget.onOpened?.call();
    });
  }

  void _closePopover() {
    if (!_isOpen) return;

    widget.onClosing?.call();
    
    _animationController.reverse().then((_) {
      _removeOverlay();
      setState(() => _isOpen = false);
      widget.onClosed?.call();
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Backdrop for click-to-close
          if (widget.interaction == BlueprintPopoverInteraction.click)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closePopover,
                child: Container(color: Colors.transparent),
              ),
            ),
          // Popover content
          if (widget.canEscapeKeyClose)
            KeyboardListener(
              focusNode: FocusNode()..requestFocus(),
              onKeyEvent: (event) {
                if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape) {
                  _closePopover();
                }
              },
              child: _buildPopoverContent(offset, size, screenSize),
            )
          else
            _buildPopoverContent(offset, size, screenSize),
        ],
      ),
    );
  }

  Widget _buildPopoverContent(Offset offset, Size size, Size screenSize) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => PopoverContent(
        content: widget.content,
        position: widget.position,
        minimal: widget.minimal,
        targetOffset: offset,
        targetSize: size,
        screenSize: screenSize,
        maxWidth: widget.maxWidth,
        maxHeight: widget.maxHeight,
        scaleAnimation: _scaleAnimation,
        fadeAnimation: _fadeAnimation,
        onPopoverHover: _onPopoverHover,
      ),
    );
  }

  void _onPopoverHover(bool isHovering) {
    _isHoveringPopover = isHovering;
    if (widget.interaction == BlueprintPopoverInteraction.hover) {
      if (!isHovering && !_isHovering) {
        Future.delayed(widget.hoverCloseDelay, () {
          if (!_isHovering && !_isHoveringPopover && mounted) {
            _closePopover();
          }
        });
      }
    }
  }

  void _onChildTap() {
    if (widget.interaction == BlueprintPopoverInteraction.click) {
      if (_isOpen) {
        _closePopover();
      } else {
        _openPopover();
      }
    }
  }

  void _onChildHover(bool isHovering) {
    _isHovering = isHovering;
    if (widget.interaction == BlueprintPopoverInteraction.hover) {
      if (isHovering && !_isOpen) {
        Future.delayed(widget.hoverOpenDelay, () {
          if (_isHovering && !_isOpen && mounted) {
            _openPopover();
          }
        });
      } else if (!isHovering) {
        Future.delayed(widget.hoverCloseDelay, () {
          if (!_isHovering && !_isHoveringPopover && mounted) {
            _closePopover();
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;

    if (widget.interaction == BlueprintPopoverInteraction.click) {
      child = GestureDetector(
        onTap: _onChildTap,
        child: child,
      );
    } else if (widget.interaction == BlueprintPopoverInteraction.hover) {
      child = MouseRegion(
        onEnter: (_) => _onChildHover(true),
        onExit: (_) => _onChildHover(false),
        child: child,
      );
    }

    return child;
  }
}

// Factory methods for common popover patterns
class BlueprintPopovers {
  static Widget click({
    required Widget child,
    required Widget content,
    BlueprintPopoverPosition position = BlueprintPopoverPosition.bottom,
    bool minimal = false,
    double? maxWidth,
    double? maxHeight,
    VoidCallback? onOpened,
    VoidCallback? onClosed,
  }) {
    return BlueprintPopover(
      content: content,
      position: position,
      interaction: BlueprintPopoverInteraction.click,
      minimal: minimal,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      onOpened: onOpened,
      onClosed: onClosed,
      child: child,
    );
  }

  static Widget hover({
    required Widget child,
    required Widget content,
    BlueprintPopoverPosition position = BlueprintPopoverPosition.top,
    bool minimal = false,
    Duration hoverOpenDelay = const Duration(milliseconds: 100),
    Duration hoverCloseDelay = const Duration(milliseconds: 300),
    double? maxWidth,
    double? maxHeight,
  }) {
    return BlueprintPopover(
      content: content,
      position: position,
      interaction: BlueprintPopoverInteraction.hover,
      minimal: minimal,
      hoverOpenDelay: hoverOpenDelay,
      hoverCloseDelay: hoverCloseDelay,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      child: child,
    );
  }

  static Widget tooltip({
    required Widget child,
    required String text,
    BlueprintPopoverPosition position = BlueprintPopoverPosition.top,
    Duration hoverOpenDelay = const Duration(milliseconds: 500),
  }) {
    return BlueprintPopover(
      content: Text(text),
      position: position,
      interaction: BlueprintPopoverInteraction.hover,
      minimal: true,
      hoverOpenDelay: hoverOpenDelay,
      child: child,
    );
  }

  static Widget menu({
    required Widget child,
    required List<Widget> items,
    BlueprintPopoverPosition position = BlueprintPopoverPosition.bottomLeft,
  }) {
    return BlueprintPopover(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: items,
      ),
      position: position,
      interaction: BlueprintPopoverInteraction.click,
      minimal: true,
      child: child,
    );
  }

  static Widget confirmation({
    required Widget child,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    BlueprintIntent confirmIntent = BlueprintIntent.danger,
    BlueprintPopoverPosition position = BlueprintPopoverPosition.top,
  }) {
    return BlueprintPopover(
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlueprintButton(
                  text: cancelText,
                  variant: BlueprintButtonVariant.minimal,
                  onPressed: onCancel ?? () {},
                ),
                const SizedBox(width: 8),
                BlueprintButton(
                  text: confirmText,
                  intent: confirmIntent,
                  onPressed: onConfirm,
                ),
              ],
            ),
          ],
        ),
      ),
      position: position,
      interaction: BlueprintPopoverInteraction.click,
      child: child,
    );
  }
}