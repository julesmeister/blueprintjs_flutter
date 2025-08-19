import 'package:flutter/material.dart';
import 'blueprint_common.dart';

class BlueprintMenuItem {
  final String text;
  final IconData? icon;
  final IconData? endIcon;
  final VoidCallback? onTap;
  final BlueprintIntent intent;
  final bool disabled;
  final bool selected;
  final List<BlueprintMenuItem>? submenu;
  final Widget? trailing;

  const BlueprintMenuItem({
    required this.text,
    this.icon,
    this.endIcon,
    this.onTap,
    this.intent = BlueprintIntent.none,
    this.disabled = false,
    this.selected = false,
    this.submenu,
    this.trailing,
  });
}

class BlueprintMenuDivider {
  final String? title;

  const BlueprintMenuDivider({this.title});
}

class BlueprintMenu extends StatelessWidget {
  final List<dynamic> items; // Can contain BlueprintMenuItem or BlueprintMenuDivider
  final EdgeInsetsGeometry? padding;
  final double? width;
  final bool large;

  const BlueprintMenu({
    Key? key,
    required this.items,
    this.padding,
    this.width,
    this.large = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      width: width ?? BlueprintTheme.menuMinWidth,
      decoration: BoxDecoration(
        color: isDark ? BlueprintColors.dark3 : BlueprintColors.white, // $menu-background-color: $white
        borderRadius: BorderRadius.circular(2), // $menu-item-border-radius: 2px
        border: Border.all(
          color: isDark ? BlueprintColors.dark1 : BlueprintColors.gray5,
          width: 1,
        ),
        // No boxShadow - Blueprint menus use only borders, not shadows
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildMenuItems(context, isDark),
      ),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context, bool isDark) {
    final List<Widget> widgets = [];
    
    // Add top padding
    widgets.add(const SizedBox(height: 5));
    
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      if (item is BlueprintMenuItem) {
        widgets.add(_buildMenuItem(context, item, isDark));
      } else if (item is BlueprintMenuDivider) {
        widgets.add(_buildMenuDivider(context, item, isDark));
      }
    }
    
    // Add bottom padding
    widgets.add(const SizedBox(height: 5));
    
    return widgets;
  }

  Widget _buildMenuItem(BuildContext context, BlueprintMenuItem item, bool isDark) {
    Color? textColor;
    Color? backgroundColor;
    
    if (item.disabled) {
      textColor = isDark ? BlueprintColors.gray1 : BlueprintColors.gray3;
    } else if (item.selected) {
      backgroundColor = isDark ? BlueprintColors.dark1 : BlueprintColors.light3;
      textColor = isDark ? BlueprintColors.light1 : BlueprintColors.dark1;
    } else {
      switch (item.intent) {
        case BlueprintIntent.primary:
          textColor = BlueprintColors.blue3;
          break;
        case BlueprintIntent.success:
          textColor = BlueprintColors.green3;
          break;
        case BlueprintIntent.warning:
          textColor = BlueprintColors.orange3;
          break;
        case BlueprintIntent.danger:
          textColor = BlueprintColors.red3;
          break;
        case BlueprintIntent.none:
          textColor = isDark ? BlueprintColors.light1 : BlueprintColors.dark1;
          break;
      }
    }

    final hasSubmenu = item.submenu != null && item.submenu!.isNotEmpty;
    final effectiveEndIcon = hasSubmenu ? Icons.chevron_right : item.endIcon;

    return Material(
      color: backgroundColor ?? Colors.transparent,
      child: InkWell(
        onTap: item.disabled ? null : item.onTap,
        hoverColor: item.disabled 
            ? Colors.transparent 
            : (isDark 
                ? Colors.transparent // Dark theme uses different hover logic
                : const Color(0x26738694)), // rgba(115, 134, 148, 0.15)
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5, // Menu-level padding
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: large ? BlueprintTheme.menuItemPaddingLarge : BlueprintTheme.menuItemPadding,
              vertical: large ? 7 : 5, // Calculated from button height - line height
            ),
          child: Row(
            children: [
              if (item.icon != null) ...[
                Icon(
                  item.icon,
                  size: large ? 18 : 16,
                  color: textColor,
                ),
                const SizedBox(width: 7),
              ],
              Expanded(
                child: Text(
                  item.text,
                  style: TextStyle(
                    fontSize: large ? BlueprintTheme.fontSizeLarge : BlueprintTheme.fontSize,
                    height: 1.4, // $menu-item-line-height-factor: 1.4
                    color: textColor,
                    fontWeight: item.selected ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
              if (item.trailing != null) ...[
                const SizedBox(width: 7),
                item.trailing!,
              ],
              if (effectiveEndIcon != null) ...[
                const SizedBox(width: 7),
                Icon(
                  effectiveEndIcon,
                  size: large ? 18 : 16,
                  color: textColor,
                ),
              ],
            ],
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildMenuDivider(BuildContext context, BlueprintMenuDivider divider, bool isDark) {
    if (divider.title != null) {
      return Container(
        padding: const EdgeInsets.fromLTRB(13, 10, 12, 0), // 5px(menu) + 2px(header) + 6px(heading) = 13px left
          child: Text(
            divider.title!.toUpperCase(),
            style: TextStyle(
              fontSize: BlueprintTheme.fontSizeSmall,
              color: isDark ? BlueprintColors.gray1 : BlueprintColors.gray2,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0, // Heading letter spacing
              height: 1.1, // Tight line height for headers
            ),
          ),
        );
    }
    
    return Container(
      margin: const EdgeInsets.only(top: 5),
      height: 1,
      color: isDark 
          ? const Color(0x30FFFFFF) // $pt-dark-divider-white
          : const Color(0x15000000), // $pt-divider-black
    );
  }
}

class BlueprintMenus {
  static BlueprintMenu simple({
    required List<BlueprintMenuItem> items,
    double? width,
  }) {
    return BlueprintMenu(
      items: items,
      width: width,
    );
  }

  static BlueprintMenu withDividers({
    required List<dynamic> items, // Mix of BlueprintMenuItem and BlueprintMenuDivider
    double? width,
  }) {
    return BlueprintMenu(
      items: items,
      width: width,
    );
  }

  static BlueprintMenu large({
    required List<BlueprintMenuItem> items,
    double? width,
  }) {
    return BlueprintMenu(
      items: items,
      width: width,
      large: true,
    );
  }
}