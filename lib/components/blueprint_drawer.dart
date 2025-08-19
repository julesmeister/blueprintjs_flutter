import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'blueprint_button.dart';
import 'blueprint_icon.dart';
import 'blueprint_common.dart';

enum BlueprintDrawerSize {
  small, // 240px
  standard, // 280px
  large, // 360px
}

enum BlueprintDrawerPosition {
  left,
  right,
  top,
  bottom,
}

class BlueprintDrawer extends StatelessWidget {
  final bool isOpen;
  final VoidCallback? onClose;
  final Widget? title;
  final Widget child;
  final BlueprintDrawerSize size;
  final BlueprintDrawerPosition position;
  final bool hasBackdrop;
  final bool canOutsideClickClose;
  final bool canEscapeKeyClose;
  final VoidCallback? onOpening;
  final VoidCallback? onOpened;
  final VoidCallback? onClosing;
  final VoidCallback? onClosed;
  final bool autoFocus;
  final bool enforceFocus;
  final bool usePortal;
  final Widget? icon;

  const BlueprintDrawer({
    super.key,
    required this.isOpen,
    this.onClose,
    this.title,
    required this.child,
    this.size = BlueprintDrawerSize.standard,
    this.position = BlueprintDrawerPosition.right,
    this.hasBackdrop = true,
    this.canOutsideClickClose = true,
    this.canEscapeKeyClose = true,
    this.onOpening,
    this.onOpened,
    this.onClosing,
    this.onClosed,
    this.autoFocus = true,
    this.enforceFocus = true,
    this.usePortal = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOpen) return const SizedBox.shrink();

    return _DrawerOverlay(
      hasBackdrop: hasBackdrop,
      canOutsideClickClose: canOutsideClickClose,
      onClose: onClose,
      child: _DrawerContainer(
        size: size,
        position: position,
        title: title,
        icon: icon,
        onClose: onClose,
        child: child,
      ),
    );
  }

  double _getDrawerSize() {
    switch (size) {
      case BlueprintDrawerSize.small:
        return 240.0; // Blueprint: $drawer-width-small
      case BlueprintDrawerSize.standard:
        return 280.0; // Blueprint: $drawer-width
      case BlueprintDrawerSize.large:
        return 360.0; // Blueprint: $drawer-width-large
    }
  }

  static void show({
    required BuildContext context,
    required Widget child,
    Widget? title,
    Widget? icon,
    BlueprintDrawerSize size = BlueprintDrawerSize.standard,
    BlueprintDrawerPosition position = BlueprintDrawerPosition.right,
    bool hasBackdrop = true,
    bool canOutsideClickClose = true,
    bool canEscapeKeyClose = true,
    VoidCallback? onClose,
  }) {
    showDialog(
      context: context,
      barrierDismissible: canOutsideClickClose,
      barrierColor: hasBackdrop ? Colors.black54 : Colors.transparent,
      builder: (context) => BlueprintDrawer(
        isOpen: true,
        onClose: onClose ?? () => Navigator.of(context).pop(),
        title: title,
        icon: icon,
        size: size,
        position: position,
        hasBackdrop: hasBackdrop,
        canOutsideClickClose: canOutsideClickClose,
        canEscapeKeyClose: canEscapeKeyClose,
        child: child,
      ),
    );
  }
}

class _DrawerOverlay extends StatelessWidget {
  final bool hasBackdrop;
  final bool canOutsideClickClose;
  final VoidCallback? onClose;
  final Widget child;

  const _DrawerOverlay({
    required this.hasBackdrop,
    required this.canOutsideClickClose,
    this.onClose,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          // Backdrop
          if (hasBackdrop)
            GestureDetector(
              onTap: canOutsideClickClose ? onClose : null,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black54, // Blueprint: $overlay-backdrop-color
              ),
            ),
          // Drawer content
          child,
        ],
      ),
    );
  }
}

class _DrawerContainer extends StatefulWidget {
  final BlueprintDrawerSize size;
  final BlueprintDrawerPosition position;
  final Widget? title;
  final Widget? icon;
  final VoidCallback? onClose;
  final Widget child;

  const _DrawerContainer({
    required this.size,
    required this.position,
    this.title,
    this.icon,
    this.onClose,
    required this.child,
  });

  @override
  State<_DrawerContainer> createState() => _DrawerContainerState();
}

class _DrawerContainerState extends State<_DrawerContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200), // Blueprint: $pt-transition-duration * 2
      vsync: this,
    );

    // Set slide direction based on position
    Offset beginOffset;
    switch (widget.position) {
      case BlueprintDrawerPosition.left:
        beginOffset = const Offset(-1.0, 0.0);
        break;
      case BlueprintDrawerPosition.right:
        beginOffset = const Offset(1.0, 0.0);
        break;
      case BlueprintDrawerPosition.top:
        beginOffset = const Offset(0.0, -1.0);
        break;
      case BlueprintDrawerPosition.bottom:
        beginOffset = const Offset(0.0, 1.0);
        break;
    }

    _slideAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutQuart, // Blueprint: $pt-transition-ease
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _getDrawerSize() {
    switch (widget.size) {
      case BlueprintDrawerSize.small:
        return 240.0; // Blueprint: $drawer-width-small
      case BlueprintDrawerSize.standard:
        return 280.0; // Blueprint: $drawer-width
      case BlueprintDrawerSize.large:
        return 360.0; // Blueprint: $drawer-width-large
    }
  }

  bool _isVertical() {
    return widget.position == BlueprintDrawerPosition.left ||
           widget.position == BlueprintDrawerPosition.right;
  }

  Alignment _getAlignment() {
    switch (widget.position) {
      case BlueprintDrawerPosition.left:
        return Alignment.centerLeft;
      case BlueprintDrawerPosition.right:
        return Alignment.centerRight;
      case BlueprintDrawerPosition.top:
        return Alignment.topCenter;
      case BlueprintDrawerPosition.bottom:
        return Alignment.bottomCenter;
    }
  }

  @override
  Widget build(BuildContext context) {
    final drawerSize = _getDrawerSize();
    final isVertical = _isVertical();

    return Align(
      alignment: _getAlignment(),
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          width: isVertical ? drawerSize : double.infinity,
          height: isVertical ? double.infinity : drawerSize,
          decoration: BoxDecoration(
            color: Colors.white, // Blueprint: $drawer-background-color
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3), // Blueprint: $pt-elevation-shadow-3
                offset: const Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                offset: const Offset(0, 4),
                blurRadius: 24,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.title != null || widget.onClose != null)
                _buildHeader(),
              Expanded(
                child: widget.child,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2), // Blueprint: $pt-grid-size * 2
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: BlueprintColors.lightGray2, // Blueprint: $pt-divider-black
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (widget.icon != null) ...[
            widget.icon!,
            const SizedBox(width: BlueprintTheme.gridSize),
          ],
          if (widget.title != null)
            Expanded(
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: BlueprintTheme.fontSizeLarge, // Blueprint: $pt-font-size-large
                  fontWeight: FontWeight.w600,
                  color: BlueprintColors.textColor,
                ),
                child: widget.title!,
              ),
            ),
          if (widget.onClose != null)
            BlueprintButton(
              variant: BlueprintButtonVariant.minimal,
              icon: Icons.close,
              onPressed: widget.onClose,
              intent: BlueprintIntent.none,
            ),
        ],
      ),
    );
  }
}

// Factory methods for common drawer patterns
class BlueprintDrawers {
  static Future<void> showRight({
    required BuildContext context,
    required Widget child,
    Widget? title,
    Widget? icon,
    BlueprintDrawerSize size = BlueprintDrawerSize.standard,
    bool hasBackdrop = true,
    bool canOutsideClickClose = true,
    VoidCallback? onClose,
  }) async {
    return BlueprintDrawer.show(
      context: context,
      child: child,
      title: title,
      icon: icon,
      size: size,
      position: BlueprintDrawerPosition.right,
      hasBackdrop: hasBackdrop,
      canOutsideClickClose: canOutsideClickClose,
      onClose: onClose,
    );
  }

  static Future<void> showLeft({
    required BuildContext context,
    required Widget child,
    Widget? title,
    Widget? icon,
    BlueprintDrawerSize size = BlueprintDrawerSize.standard,
    bool hasBackdrop = true,
    bool canOutsideClickClose = true,
    VoidCallback? onClose,
  }) async {
    return BlueprintDrawer.show(
      context: context,
      child: child,
      title: title,
      icon: icon,
      size: size,
      position: BlueprintDrawerPosition.left,
      hasBackdrop: hasBackdrop,
      canOutsideClickClose: canOutsideClickClose,
      onClose: onClose,
    );
  }

  static Future<void> showNavigation({
    required BuildContext context,
    required List<DrawerNavigationItem> items,
    String? title,
    Widget? icon,
    BlueprintDrawerSize size = BlueprintDrawerSize.standard,
    BlueprintDrawerPosition position = BlueprintDrawerPosition.left,
  }) async {
    return BlueprintDrawer.show(
      context: context,
      title: title != null ? Text(title) : null,
      icon: icon,
      size: size,
      position: position,
      child: _NavigationDrawerContent(items: items),
    );
  }

  static Widget withContent({
    required Widget child,
    Widget? title,
    Widget? icon,
    BlueprintDrawerSize size = BlueprintDrawerSize.standard,
    EdgeInsets padding = const EdgeInsets.all(BlueprintTheme.gridSize * 2),
  }) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null) ...[
            DefaultTextStyle(
              style: TextStyle(
                fontSize: BlueprintTheme.fontSizeLarge,
                fontWeight: FontWeight.w600,
                color: BlueprintColors.textColor,
              ),
              child: title,
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 2),
          ],
          Expanded(child: child),
        ],
      ),
    );
  }
}

class DrawerNavigationItem {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isActive;
  final bool disabled;
  final List<DrawerNavigationItem>? children;

  const DrawerNavigationItem({
    required this.label,
    this.icon,
    this.onTap,
    this.isActive = false,
    this.disabled = false,
    this.children,
  });
}

class _NavigationDrawerContent extends StatelessWidget {
  final List<DrawerNavigationItem> items;

  const _NavigationDrawerContent({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: BlueprintTheme.gridSize),
      children: items.map((item) => _buildNavigationItem(context, item)).toList(),
    );
  }

  Widget _buildNavigationItem(BuildContext context, DrawerNavigationItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: BlueprintTheme.gridSize,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: item.isActive ? BlueprintColors.intentPrimary.withValues(alpha: 0.1) : null,
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
      ),
      child: ListTile(
        leading: item.icon != null 
            ? Icon(
                item.icon,
                color: item.isActive 
                    ? BlueprintColors.intentPrimary
                    : item.disabled
                        ? BlueprintColors.textColorMuted
                        : BlueprintColors.textColor,
                size: 16,
              )
            : null,
        title: Text(
          item.label,
          style: TextStyle(
            color: item.isActive 
                ? BlueprintColors.intentPrimary
                : item.disabled
                    ? BlueprintColors.textColorMuted
                    : BlueprintColors.textColor,
            fontWeight: item.isActive ? FontWeight.w600 : FontWeight.normal,
            fontSize: BlueprintTheme.fontSize,
          ),
        ),
        onTap: item.disabled ? null : item.onTap,
        dense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: BlueprintTheme.gridSize,
          vertical: 4,
        ),
      ),
    );
  }
}