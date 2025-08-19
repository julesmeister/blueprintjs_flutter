import 'blueprint_common.dart';

class BlueprintIcon extends StatelessWidget {
  final IconData icon;
  final BlueprintSize size;
  final Color? color;
  final BlueprintIntent? intent;
  final String? title;
  final String? semanticLabel;

  const BlueprintIcon({
    super.key,
    required this.icon,
    this.size = BlueprintSize.normal,
    this.color,
    this.intent,
    this.title,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Icon(
      icon,
      size: size.iconSize, // Use extension method
      color: color ?? intent?.color ?? BlueprintColors.gray1, // Use extension method
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
}

// Factory methods for common icon patterns
class BlueprintIcons {
  // Size-based factory methods
  static Widget small({
    required IconData icon,
    Color? color,
    BlueprintIntent? intent,
    String? title,
    String? semanticLabel,
  }) =>
      BlueprintIcon(
        icon: icon,
        size: BlueprintSize.small,
        color: color,
        intent: intent,
        title: title,
        semanticLabel: semanticLabel,
      );

  static Widget standard({
    required IconData icon,
    Color? color,
    BlueprintIntent? intent,
    String? title,
    String? semanticLabel,
  }) =>
      BlueprintIcon(
        icon: icon,
        size: BlueprintSize.normal,
        color: color,
        intent: intent,
        title: title,
        semanticLabel: semanticLabel,
      );

  static Widget large({
    required IconData icon,
    Color? color,
    BlueprintIntent? intent,
    String? title,
    String? semanticLabel,
  }) =>
      BlueprintIcon(
        icon: icon,
        size: BlueprintSize.large,
        color: color,
        intent: intent,
        title: title,
        semanticLabel: semanticLabel,
      );

  // Intent-based factory methods
  static Widget withIntent({
    required IconData icon,
    required BlueprintIntent intent,
    BlueprintSize size = BlueprintSize.normal,
    String? title,
    String? semanticLabel,
  }) =>
      BlueprintIcon(
        icon: icon,
        size: size,
        intent: intent,
        title: title,
        semanticLabel: semanticLabel,
      );

  // Helper method to reduce duplication
  static Widget _intentIcon({
    required IconData icon,
    required BlueprintIntent intent,
    BlueprintSize size = BlueprintSize.normal,
    String? title,
    String? semanticLabel,
  }) =>
      BlueprintIcon(
        icon: icon,
        size: size,
        intent: intent,
        title: title,
        semanticLabel: semanticLabel,
      );

  static Widget primary({
    required IconData icon,
    BlueprintSize size = BlueprintSize.normal,
    String? title,
    String? semanticLabel,
  }) =>
      _intentIcon(
        icon: icon,
        intent: BlueprintIntent.primary,
        size: size,
        title: title,
        semanticLabel: semanticLabel,
      );

  static Widget success({
    required IconData icon,
    BlueprintSize size = BlueprintSize.normal,
    String? title,
    String? semanticLabel,
  }) =>
      _intentIcon(
        icon: icon,
        intent: BlueprintIntent.success,
        size: size,
        title: title,
        semanticLabel: semanticLabel,
      );

  static Widget warning({
    required IconData icon,
    BlueprintSize size = BlueprintSize.normal,
    String? title,
    String? semanticLabel,
  }) =>
      _intentIcon(
        icon: icon,
        intent: BlueprintIntent.warning,
        size: size,
        title: title,
        semanticLabel: semanticLabel,
      );

  static Widget danger({
    required IconData icon,
    BlueprintSize size = BlueprintSize.normal,
    String? title,
    String? semanticLabel,
  }) =>
      _intentIcon(
        icon: icon,
        intent: BlueprintIntent.danger,
        size: size,
        title: title,
        semanticLabel: semanticLabel,
      );

  // Helper method for semantic icons with custom color/intent
  static Widget _semanticIcon({
    required IconData iconData,
    BlueprintSize size = BlueprintSize.normal,
    Color? color,
    BlueprintIntent? intent,
    required String title,
  }) =>
      BlueprintIcon(
        icon: iconData,
        size: size,
        color: color,
        intent: intent,
        title: title,
        semanticLabel: title,
      );

  // Common Blueprint icons with semantic meanings
  static Widget home({
    BlueprintSize size = BlueprintSize.normal,
    Color? color,
    String? title = 'Home',
  }) =>
      _semanticIcon(
        iconData: Icons.home,
        size: size,
        color: color,
        title: title!,
      );

  static Widget settings({
    BlueprintSize size = BlueprintSize.normal,
    Color? color,
    String? title = 'Settings',
  }) =>
      _semanticIcon(
        iconData: Icons.settings,
        size: size,
        color: color,
        title: title!,
      );

  static Widget add({
    BlueprintSize size = BlueprintSize.normal,
    Color? color,
    String? title = 'Add',
  }) =>
      _semanticIcon(
        iconData: Icons.add,
        size: size,
        color: color,
        title: title!,
      );

  static Widget remove({
    BlueprintSize size = BlueprintSize.normal,
    Color? color,
    String? title = 'Remove',
  }) =>
      _semanticIcon(
        iconData: Icons.remove,
        size: size,
        color: color,
        title: title!,
      );

  static Widget edit({
    BlueprintSize size = BlueprintSize.normal,
    Color? color,
    String? title = 'Edit',
  }) =>
      _semanticIcon(
        iconData: Icons.edit,
        size: size,
        color: color,
        title: title!,
      );

  // Intent-based semantic icons
  static Widget delete({
    BlueprintSize size = BlueprintSize.normal,
    String? title = 'Delete',
  }) =>
      _semanticIcon(
        iconData: Icons.delete,
        size: size,
        intent: BlueprintIntent.danger,
        title: title!,
      );

  static Widget save({
    BlueprintSize size = BlueprintSize.normal,
    String? title = 'Save',
  }) =>
      _semanticIcon(
        iconData: Icons.save,
        size: size,
        intent: BlueprintIntent.primary,
        title: title!,
      );

  static Widget cancel({
    BlueprintSize size = BlueprintSize.normal,
    String? title = 'Cancel',
  }) =>
      _semanticIcon(
        iconData: Icons.close,
        size: size,
        color: BlueprintColors.textColorMuted,
        title: title!,
      );

  static Widget info({
    BlueprintSize size = BlueprintSize.normal,
    String? title = 'Information',
  }) =>
      _semanticIcon(
        iconData: Icons.info,
        size: size,
        intent: BlueprintIntent.primary,
        title: title!,
      );

  static Widget warningTriangle({
    BlueprintSize size = BlueprintSize.normal,
    String? title = 'Warning',
  }) =>
      _semanticIcon(
        iconData: Icons.warning,
        size: size,
        intent: BlueprintIntent.warning,
        title: title!,
      );

  static Widget error({
    BlueprintSize size = BlueprintSize.normal,
    String? title = 'Error',
  }) =>
      _semanticIcon(
        iconData: Icons.error,
        size: size,
        intent: BlueprintIntent.danger,
        title: title!,
      );

  static Widget successCheck({
    BlueprintSize size = BlueprintSize.normal,
    String? title = 'Success',
  }) =>
      _semanticIcon(
        iconData: Icons.check_circle,
        size: size,
        intent: BlueprintIntent.success,
        title: title!,
      );

  static Widget search({
    BlueprintSize size = BlueprintSize.normal,
    Color? color,
    String? title = 'Search',
  }) =>
      _semanticIcon(
        iconData: Icons.search,
        size: size,
        color: color,
        title: title!,
      );

  static Widget menu({
    BlueprintSize size = BlueprintSize.normal,
    Color? color,
    String? title = 'Menu',
  }) =>
      _semanticIcon(
        iconData: Icons.menu,
        size: size,
        color: color,
        title: title!,
      );

  static Widget more({
    BlueprintSize size = BlueprintSize.normal,
    Color? color,
    String? title = 'More options',
  }) =>
      _semanticIcon(
        iconData: Icons.more_horiz,
        size: size,
        color: color,
        title: title!,
      );
}