import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';

enum BlueprintIntent {
  none,
  primary,
  success,
  warning,
  danger,
}

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
      width: width ?? 200,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? BlueprintColors.dark3 : BlueprintColors.light5,
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
        border: Border.all(
          color: isDark ? BlueprintColors.dark1 : BlueprintColors.gray5,
          width: 1,
        ),
        boxShadow: BlueprintTheme.elevation2,
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
    
    for (final item in items) {
      if (item is BlueprintMenuItem) {
        widgets.add(_buildMenuItem(context, item, isDark));
      } else if (item is BlueprintMenuDivider) {
        widgets.add(_buildMenuDivider(context, item, isDark));
      }
    }
    
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
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: large ? 8 : 6,
          ),
          child: Row(
            children: [
              if (item.icon != null) ...[
                Icon(
                  item.icon,
                  size: large ? 18 : 16,
                  color: textColor,
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  item.text,
                  style: TextStyle(
                    fontSize: large ? BlueprintTheme.fontSizeLarge : BlueprintTheme.fontSize,
                    color: textColor,
                    fontWeight: item.selected ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
              if (item.trailing != null) ...[
                const SizedBox(width: 8),
                item.trailing!,
              ],
              if (effectiveEndIcon != null) ...[
                const SizedBox(width: 8),
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
    );
  }

  Widget _buildMenuDivider(BuildContext context, BlueprintMenuDivider divider, bool isDark) {
    if (divider.title != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          divider.title!,
          style: TextStyle(
            fontSize: BlueprintTheme.fontSizeSmall,
            color: isDark ? BlueprintColors.gray1 : BlueprintColors.gray2,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      );
    }
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 1,
      color: isDark ? BlueprintColors.dark1 : BlueprintColors.gray5,
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