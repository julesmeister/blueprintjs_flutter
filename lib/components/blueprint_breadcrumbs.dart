import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';

class BlueprintBreadcrumbItem {
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isCurrent;

  const BlueprintBreadcrumbItem({
    required this.text,
    this.icon,
    this.onTap,
    this.isCurrent = false,
  });
}

class BlueprintBreadcrumbs extends StatelessWidget {
  final List<BlueprintBreadcrumbItem> items;
  final int minVisibleItems;
  final Widget? separator;
  final TextStyle? textStyle;
  final TextStyle? currentTextStyle;
  final EdgeInsetsGeometry? padding;

  const BlueprintBreadcrumbs({
    Key? key,
    required this.items,
    this.minVisibleItems = 1,
    this.separator,
    this.textStyle,
    this.currentTextStyle,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final defaultTextStyle = TextStyle(
      fontSize: BlueprintTheme.fontSize,
      color: isDark ? BlueprintColors.gray1 : BlueprintColors.gray2,
      fontWeight: FontWeight.w400,
    );

    final defaultCurrentTextStyle = TextStyle(
      fontSize: BlueprintTheme.fontSize,
      color: isDark ? BlueprintColors.light1 : BlueprintColors.dark1,
      fontWeight: FontWeight.w500,
    );

    final defaultSeparator = Icon(
      Icons.chevron_right,
      size: 16,
      color: isDark ? BlueprintColors.gray3 : BlueprintColors.gray4,
    );

    return Container(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: _buildBreadcrumbItems(
          defaultTextStyle,
          defaultCurrentTextStyle,
          defaultSeparator,
        ),
      ),
    );
  }

  List<Widget> _buildBreadcrumbItems(
    TextStyle defaultTextStyle,
    TextStyle defaultCurrentTextStyle,
    Widget defaultSeparator,
  ) {
    final List<Widget> widgets = [];
    
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final isLast = i == items.length - 1;
      final effectiveTextStyle = item.isCurrent || isLast 
          ? (currentTextStyle ?? defaultCurrentTextStyle)
          : (textStyle ?? defaultTextStyle);

      // Add breadcrumb item
      widgets.add(_buildBreadcrumbItem(item, effectiveTextStyle));

      // Add separator if not last item
      if (!isLast) {
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: separator ?? defaultSeparator,
        ));
      }
    }

    return widgets;
  }

  Widget _buildBreadcrumbItem(BlueprintBreadcrumbItem item, TextStyle textStyle) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.icon != null) ...[
          Icon(
            item.icon,
            size: 16,
            color: textStyle.color,
          ),
          const SizedBox(width: 4),
        ],
        Text(
          item.text,
          style: textStyle,
        ),
      ],
    );

    if (item.onTap != null && !item.isCurrent) {
      return InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: content,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: content,
    );
  }
}

class BlueprintBreadcrumbsFactory {
  static BlueprintBreadcrumbs simple({
    required List<BlueprintBreadcrumbItem> items,
    EdgeInsetsGeometry? padding,
  }) {
    return BlueprintBreadcrumbs(
      items: items,
      padding: padding,
    );
  }

  static BlueprintBreadcrumbs withSeparator({
    required List<BlueprintBreadcrumbItem> items,
    required Widget separator,
    EdgeInsetsGeometry? padding,
  }) {
    return BlueprintBreadcrumbs(
      items: items,
      separator: separator,
      padding: padding,
    );
  }

  static BlueprintBreadcrumbs minimal({
    required List<BlueprintBreadcrumbItem> items,
  }) {
    return BlueprintBreadcrumbs(
      items: items,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      separator: const Icon(
        Icons.chevron_right,
        size: 14,
      ),
    );
  }
}