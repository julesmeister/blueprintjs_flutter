import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';

enum BlueprintElevation {
  zero,
  one,
  two,
  three,
  four,
}

class BlueprintCard extends StatefulWidget {
  final Widget? child;
  final BlueprintElevation elevation;
  final bool interactive;
  final bool selected;
  final bool compact;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  const BlueprintCard({
    Key? key,
    this.child,
    this.elevation = BlueprintElevation.zero,
    this.interactive = false,
    this.selected = false,
    this.compact = false,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<BlueprintCard> createState() => _BlueprintCardState();
}

class _BlueprintCardState extends State<BlueprintCard> {
  bool _isHovered = false;

  List<BoxShadow> get _shadows {
    final baseElevation = widget.interactive && _isHovered 
        ? _getNextElevation(widget.elevation)
        : widget.elevation;
    
    switch (baseElevation) {
      case BlueprintElevation.zero:
        return BlueprintTheme.elevation0;
      case BlueprintElevation.one:
        return BlueprintTheme.elevation1;
      case BlueprintElevation.two:
        return BlueprintTheme.elevation1; // Use subtle shadow like elevation1
      case BlueprintElevation.three:
        return BlueprintTheme.elevation2; // Use subtle shadow like elevation2
      case BlueprintElevation.four:
        return BlueprintTheme.elevation2; // Use subtle shadow like elevation2
    }
  }

  BlueprintElevation _getNextElevation(BlueprintElevation current) {
    switch (current) {
      case BlueprintElevation.zero:
        return BlueprintElevation.one;
      case BlueprintElevation.one:
        return BlueprintElevation.two;
      case BlueprintElevation.two:
        return BlueprintElevation.three;
      case BlueprintElevation.three:
        return BlueprintElevation.four;
      case BlueprintElevation.four:
        return BlueprintElevation.four;
    }
  }

  EdgeInsetsGeometry get _defaultPadding {
    if (widget.compact) {
      return const EdgeInsets.all(BlueprintTheme.gridSize);
    }
    return const EdgeInsets.all(BlueprintTheme.gridSize * 2);
  }

  Color get _backgroundColor {
    if (widget.backgroundColor != null) return widget.backgroundColor!;
    
    if (widget.selected) {
      return BlueprintColors.intentPrimary.withValues(alpha: 0.1);
    }
    
    return BlueprintColors.appSecondaryBackgroundColor;
  }

  BorderRadius get _borderRadius {
    return widget.borderRadius ?? BorderRadius.circular(BlueprintTheme.borderRadius);
  }

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Container(
      padding: widget.padding ?? _defaultPadding,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: _borderRadius,
        boxShadow: _shadows,
        border: widget.selected 
            ? Border.all(color: BlueprintColors.intentPrimary, width: 1)
            : Border.all(color: BlueprintColors.lightGray2, width: 1), // Default Blueprint.js card border
      ),
      child: widget.child,
    );

    if (widget.interactive || widget.onTap != null) {
      cardContent = Material(
        color: Colors.transparent,
        borderRadius: _borderRadius,
        child: InkWell(
          borderRadius: _borderRadius,
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          onHover: (hovering) => setState(() => _isHovered = hovering),
          child: cardContent,
        ),
      );
    }

    if (widget.margin != null) {
      cardContent = Container(
        margin: widget.margin,
        child: cardContent,
      );
    }

    return cardContent;
  }
}

class BlueprintCardList extends StatelessWidget {
  final List<Widget> children;
  final bool bordered;
  final bool compact;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? role;

  const BlueprintCardList({
    Key? key,
    required this.children,
    this.bordered = true,
    this.compact = false,
    this.padding,
    this.margin,
    this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Blueprint.js CardList creates a container that has zero elevation
    // and acts as a wrapper for multiple cards
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );

    if (padding != null) {
      content = Padding(
        padding: padding!,
        child: content,
      );
    }

    if (bordered) {
      content = Container(
        margin: isDark ? const EdgeInsets.all(1) : null, // Dark theme margin
        decoration: BoxDecoration(
          color: BlueprintColors.appSecondaryBackgroundColor,
          borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
          boxShadow: BlueprintTheme.elevation0,
          border: Border.all(color: BlueprintColors.lightGray2, width: 1), // Default Blueprint.js border
        ),
        child: content,
      );
    }

    if (margin != null) {
      content = Container(
        margin: margin,
        child: content,
      );
    }

    return content;
  }
}

// Helper widgets for common card patterns
class BlueprintCardHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  const BlueprintCardHeader({
    Key? key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: BlueprintTheme.gridSize),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: const TextStyle(
                        fontSize: BlueprintTheme.fontSize,
                        fontWeight: FontWeight.w600,
                        color: BlueprintColors.headingColor,
                      ),
                    ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: BlueprintTheme.fontSizeSmall,
                        color: BlueprintColors.textColorMuted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: BlueprintTheme.gridSize),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

class BlueprintCardSection extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Border? border;

  const BlueprintCardSection({
    Key? key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(BlueprintTheme.gridSize),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: border ?? const Border(
          top: BorderSide(color: BlueprintColors.dividerBlackMuted),
        ),
      ),
      child: child,
    );
  }
}

class BlueprintCircleAvatar extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color? textColor;
  final double? size;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double verticalOffset;

  const BlueprintCircleAvatar({
    Key? key,
    required this.text,
    required this.backgroundColor,
    this.textColor = Colors.white,
    this.size = 40,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.verticalOffset = -1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(0, verticalOffset),
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: fontWeight,
                    fontSize: fontSize,
                    height: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}