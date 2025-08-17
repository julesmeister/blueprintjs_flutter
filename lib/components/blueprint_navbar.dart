import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';

enum BlueprintNavbarAlignment {
  start,
  center,
  end,
}

class BlueprintNavbar extends StatelessWidget {
  final List<Widget> children;
  final bool fixedToTop;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final bool hasBorder;

  const BlueprintNavbar({
    Key? key,
    required this.children,
    this.fixedToTop = false,
    this.height,
    this.padding,
    this.backgroundColor,
    this.hasBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveHeight = height ?? 50.0;
    
    final defaultBackgroundColor = isDark 
        ? BlueprintColors.dark3 
        : BlueprintColors.light5;

    final navbar = Container(
      height: effectiveHeight,
      width: double.infinity,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? defaultBackgroundColor,
        border: hasBorder ? Border(
          bottom: BorderSide(
            color: isDark ? BlueprintColors.dark1 : BlueprintColors.gray5,
            width: 1,
          ),
        ) : null,
        boxShadow: fixedToTop ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 4,
          ),
        ] : null,
      ),
      child: Row(
        children: children,
      ),
    );

    if (fixedToTop) {
      return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: navbar,
      );
    }

    return navbar;
  }
}

class BlueprintNavbarGroup extends StatelessWidget {
  final List<Widget> children;
  final BlueprintNavbarAlignment alignment;
  final double? spacing;

  const BlueprintNavbarGroup({
    Key? key,
    required this.children,
    this.alignment = BlueprintNavbarAlignment.start,
    this.spacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveSpacing = spacing ?? 8.0;
    
    final content = Wrap(
      spacing: effectiveSpacing,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
    );

    switch (alignment) {
      case BlueprintNavbarAlignment.start:
        return Align(
          alignment: Alignment.centerLeft,
          child: content,
        );
      case BlueprintNavbarAlignment.center:
        return Expanded(
          child: Center(child: content),
        );
      case BlueprintNavbarAlignment.end:
        return Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: content,
          ),
        );
    }
  }
}

class BlueprintNavbarHeading extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const BlueprintNavbarHeading({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final defaultStyle = TextStyle(
      fontSize: BlueprintTheme.fontSizeLarge,
      fontWeight: FontWeight.w600,
      color: isDark ? BlueprintColors.light1 : BlueprintColors.dark1,
    );

    return Text(
      text,
      style: style ?? defaultStyle,
    );
  }
}

class BlueprintNavbarDivider extends StatelessWidget {
  final double? height;
  final Color? color;

  const BlueprintNavbarDivider({
    Key? key,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveHeight = height ?? 24.0;
    
    return Container(
      width: 1,
      height: effectiveHeight,
      color: color ?? (isDark ? BlueprintColors.dark1 : BlueprintColors.gray5),
    );
  }
}

class BlueprintNavbars {
  static BlueprintNavbar simple({
    required List<Widget> children,
    bool fixedToTop = false,
  }) {
    return BlueprintNavbar(
      children: children,
      fixedToTop: fixedToTop,
    );
  }

  static BlueprintNavbar withGroups({
    Widget? start,
    Widget? center,
    Widget? end,
    bool fixedToTop = false,
  }) {
    final children = <Widget>[];
    
    if (start != null) {
      children.add(BlueprintNavbarGroup(
        alignment: BlueprintNavbarAlignment.start,
        children: [start],
      ));
    }
    
    if (center != null) {
      children.add(BlueprintNavbarGroup(
        alignment: BlueprintNavbarAlignment.center,
        children: [center],
      ));
    }
    
    if (end != null) {
      children.add(BlueprintNavbarGroup(
        alignment: BlueprintNavbarAlignment.end,
        children: [end],
      ));
    }
    
    return BlueprintNavbar(
      children: children,
      fixedToTop: fixedToTop,
    );
  }

  static BlueprintNavbar minimal({
    required List<Widget> children,
  }) {
    return BlueprintNavbar(
      children: children,
      hasBorder: false,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 40,
    );
  }
}