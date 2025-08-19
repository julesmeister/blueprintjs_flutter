import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';

class BlueprintDivider extends StatelessWidget {
  final bool vertical;
  final bool compact;
  final Color? color;
  final double? thickness;
  final double? indent;
  final double? endIndent;

  const BlueprintDivider({
    super.key,
    this.vertical = false,
    this.compact = false,
    this.color,
    this.thickness,
    this.indent,
    this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = isDark ? BlueprintColors.dark1 : BlueprintColors.gray5;
    final dividerColor = color ?? defaultColor;
    final dividerThickness = thickness ?? 1.0;
    
    final margin = compact ? 0.0 : BlueprintTheme.gridSize.toDouble();

    if (vertical) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: margin),
        child: VerticalDivider(
          color: dividerColor,
          thickness: dividerThickness,
          indent: indent,
          endIndent: endIndent,
          width: dividerThickness,
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: margin),
        child: Divider(
          color: dividerColor,
          thickness: dividerThickness,
          indent: indent,
          endIndent: endIndent,
          height: dividerThickness,
        ),
      );
    }
  }
}

class BlueprintDividers {
  static BlueprintDivider horizontal({
    bool compact = false,
    Color? color,
    double? thickness,
  }) {
    return BlueprintDivider(
      compact: compact,
      color: color,
      thickness: thickness,
    );
  }

  static BlueprintDivider vertical({
    bool compact = false,
    Color? color,
    double? thickness,
  }) {
    return BlueprintDivider(
      vertical: true,
      compact: compact,
      color: color,
      thickness: thickness,
    );
  }

  static BlueprintDivider compact() {
    return const BlueprintDivider(compact: true);
  }

  static BlueprintDivider withColor(Color color) {
    return BlueprintDivider(color: color);
  }
}