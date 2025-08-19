import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'blueprint_button.dart';
import 'blueprint_common.dart';

enum BlueprintIconSize {
  small,    // 12px
  standard, // 16px  
  large,    // 20px
}

class BlueprintIcon extends StatelessWidget {
  final IconData icon;
  final BlueprintIconSize size;
  final Color? color;
  final BlueprintIntent? intent;
  final String? title;
  final String? semanticLabel;

  const BlueprintIcon({
    Key? key,
    required this.icon,
    this.size = BlueprintIconSize.standard,
    this.color,
    this.intent,
    this.title,
    this.semanticLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Icon(
      icon,
      size: _getIconSize(),
      color: _getIconColor(),
      semanticLabel: semanticLabel,
    );

    if (title != null) {
      iconWidget = Tooltip(
        message: title!,
        child: iconWidget,
      );
    }

    return iconWidget;
  }

  double _getIconSize() {
    switch (size) {
      case BlueprintIconSize.small:
        return 12.0;
      case BlueprintIconSize.standard:
        return 16.0;
      case BlueprintIconSize.large:
        return 20.0;
    }
  }

  Color _getIconColor() {
    if (color != null) return color!;
    
    if (intent != null) {
      switch (intent!) {
        case BlueprintIntent.primary:
          return BlueprintColors.intentPrimary;
        case BlueprintIntent.success:
          return BlueprintColors.intentSuccess;
        case BlueprintIntent.warning:
          return BlueprintColors.intentWarning;
        case BlueprintIntent.danger:
          return BlueprintColors.intentDanger;
        case BlueprintIntent.none:
          break;
      }
    }
    
    return BlueprintColors.gray1; // Default Blueprint icon color
  }
}

// Factory methods for common icon patterns
class BlueprintIcons {
  static Widget small({
    required IconData icon,
    Color? color,
    BlueprintIntent? intent,
    String? title,
    String? semanticLabel,
  }) {
    return BlueprintIcon(
      icon: icon,
      size: BlueprintIconSize.small,
      color: color,
      intent: intent,
      title: title,
      semanticLabel: semanticLabel,
    );
  }

  static Widget standard({
    required IconData icon,
    Color? color,
    BlueprintIntent? intent,
    String? title,
    String? semanticLabel,
  }) {
    return BlueprintIcon(
      icon: icon,
      size: BlueprintIconSize.standard,
      color: color,
      intent: intent,
      title: title,
      semanticLabel: semanticLabel,
    );
  }

  static Widget large({
    required IconData icon,
    Color? color,
    BlueprintIntent? intent,
    String? title,
    String? semanticLabel,
  }) {
    return BlueprintIcon(
      icon: icon,
      size: BlueprintIconSize.large,
      color: color,
      intent: intent,
      title: title,
      semanticLabel: semanticLabel,
    );
  }

  static Widget withIntent({
    required IconData icon,
    required BlueprintIntent intent,
    BlueprintIconSize size = BlueprintIconSize.standard,
    String? title,
    String? semanticLabel,
  }) {
    return BlueprintIcon(
      icon: icon,
      size: size,
      intent: intent,
      title: title,
      semanticLabel: semanticLabel,
    );
  }

  static Widget primary({
    required IconData icon,
    BlueprintIconSize size = BlueprintIconSize.standard,
    String? title,
    String? semanticLabel,
  }) {
    return BlueprintIcon(
      icon: icon,
      size: size,
      intent: BlueprintIntent.primary,
      title: title,
      semanticLabel: semanticLabel,
    );
  }

  static Widget success({
    required IconData icon,
    BlueprintIconSize size = BlueprintIconSize.standard,
    String? title,
    String? semanticLabel,
  }) {
    return BlueprintIcon(
      icon: icon,
      size: size,
      intent: BlueprintIntent.success,
      title: title,
      semanticLabel: semanticLabel,
    );
  }

  static Widget warning({
    required IconData icon,
    BlueprintIconSize size = BlueprintIconSize.standard,
    String? title,
    String? semanticLabel,
  }) {
    return BlueprintIcon(
      icon: icon,
      size: size,
      intent: BlueprintIntent.warning,
      title: title,
      semanticLabel: semanticLabel,
    );
  }

  static Widget danger({
    required IconData icon,
    BlueprintIconSize size = BlueprintIconSize.standard,
    String? title,
    String? semanticLabel,
  }) {
    return BlueprintIcon(
      icon: icon,
      size: size,
      intent: BlueprintIntent.danger,
      title: title,
      semanticLabel: semanticLabel,
    );
  }

  // Common Blueprint icons with semantic meanings
  static Widget home({
    BlueprintIconSize size = BlueprintIconSize.standard,
    Color? color,
    String? title = 'Home',
  }) {
    return BlueprintIcon(
      icon: Icons.home,
      size: size,
      color: color,
      title: title,
      semanticLabel: title,
    );
  }

  static Widget settings({
    BlueprintIconSize size = BlueprintIconSize.standard,
    Color? color,
    String? title = 'Settings',
  }) {
    return BlueprintIcon(
      icon: Icons.settings,
      size: size,
      color: color,
      title: title,
      semanticLabel: title,
    );
  }

  static Widget add({
    BlueprintIconSize size = BlueprintIconSize.standard,
    Color? color,
    String? title = 'Add',
  }) {
    return BlueprintIcon(
      icon: Icons.add,
      size: size,
      color: color,
      title: title,
      semanticLabel: title,
    );
  }

  static Widget remove({
    BlueprintIconSize size = BlueprintIconSize.standard,
    Color? color,
    String? title = 'Remove',
  }) {
    return BlueprintIcon(
      icon: Icons.remove,
      size: size,
      color: color,
      title: title,
      semanticLabel: title,
    );
  }

  static Widget edit({
    BlueprintIconSize size = BlueprintIconSize.standard,
    Color? color,
    String? title = 'Edit',
  }) {
    return BlueprintIcon(
      icon: Icons.edit,
      size: size,
      color: color,
      title: title,
      semanticLabel: title,
    );
  }

  static Widget delete({
    BlueprintIconSize size = BlueprintIconSize.standard,
    String? title = 'Delete',
  }) {
    return BlueprintIcon(
      icon: Icons.delete,
      size: size,
      intent: BlueprintIntent.danger,
      title: title,
      semanticLabel: title,
    );
  }

  static Widget save({
    BlueprintIconSize size = BlueprintIconSize.standard,
    String? title = 'Save',
  }) {
    return BlueprintIcon(
      icon: Icons.save,
      size: size,
      intent: BlueprintIntent.primary,
      title: title,
      semanticLabel: title,
    );
  }

  static Widget cancel({
    BlueprintIconSize size = BlueprintIconSize.standard,
    String? title = 'Cancel',
  }) {
    return BlueprintIcon(
      icon: Icons.close,
      size: size,
      color: BlueprintColors.textColorMuted,
      title: title,
      semanticLabel: title,
    );
  }

  static Widget info({
    BlueprintIconSize size = BlueprintIconSize.standard,
    String? title = 'Information',
  }) {
    return BlueprintIcon(
      icon: Icons.info,
      size: size,
      intent: BlueprintIntent.primary,
      title: title,
      semanticLabel: title,
    );
  }

  static Widget warning_triangle({
    BlueprintIconSize size = BlueprintIconSize.standard,
    String? title = 'Warning',
  }) {
    return BlueprintIcon(
      icon: Icons.warning,
      size: size,
      intent: BlueprintIntent.warning,
      title: title,
      semanticLabel: title,
    );
  }

  static Widget error({
    BlueprintIconSize size = BlueprintIconSize.standard,
    String? title = 'Error',
  }) {
    return BlueprintIcon(
      icon: Icons.error,
      size: size,
      intent: BlueprintIntent.danger,
      title: title,
      semanticLabel: title,
    );
  }

  static Widget success_check({
    BlueprintIconSize size = BlueprintIconSize.standard,
    String? title = 'Success',
  }) {
    return BlueprintIcon(
      icon: Icons.check_circle,
      size: size,
      intent: BlueprintIntent.success,
      title: title,
      semanticLabel: title,
    );
  }

  static Widget search({
    BlueprintIconSize size = BlueprintIconSize.standard,
    Color? color,
    String? title = 'Search',
  }) {
    return BlueprintIcon(
      icon: Icons.search,
      size: size,
      color: color,
      title: title,
      semanticLabel: title,
    );
  }

  static Widget menu({
    BlueprintIconSize size = BlueprintIconSize.standard,
    Color? color,
    String? title = 'Menu',
  }) {
    return BlueprintIcon(
      icon: Icons.menu,
      size: size,
      color: color,
      title: title,
      semanticLabel: title,
    );
  }

  static Widget more({
    BlueprintIconSize size = BlueprintIconSize.standard,
    Color? color,
    String? title = 'More options',
  }) {
    return BlueprintIcon(
      icon: Icons.more_horiz,
      size: size,
      color: color,
      title: title,
      semanticLabel: title,
    );
  }
}