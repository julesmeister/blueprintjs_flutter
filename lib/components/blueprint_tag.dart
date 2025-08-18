import 'package:flutter/material.dart';
import 'tag/tag_enums.dart';
import 'tag/tag_widget.dart';
import 'tag/compound_tag_widget.dart';

// Re-export all tag components
export 'tag/tag_enums.dart';
export 'tag/tag_widget.dart';
export 'tag/compound_tag_widget.dart';

// Factory methods for common tag types
class BlueprintTags {
  static Widget simple({
    required String text,
    IconData? icon,
    BlueprintIntent intent = BlueprintIntent.none,
    BlueprintTagSize size = BlueprintTagSize.medium,
    VoidCallback? onTap,
  }) {
    return BlueprintTag(
      text: text,
      icon: icon,
      intent: intent,
      size: size,
      interactive: onTap != null,
      onTap: onTap,
    );
  }

  static Widget minimal({
    required String text,
    IconData? icon,
    BlueprintIntent intent = BlueprintIntent.none,
    BlueprintTagSize size = BlueprintTagSize.medium,
    VoidCallback? onTap,
  }) {
    return BlueprintTag(
      text: text,
      icon: icon,
      intent: intent,
      size: size,
      minimal: true,
      interactive: onTap != null,
      onTap: onTap,
    );
  }

  static Widget removable({
    required String text,
    required VoidCallback onRemove,
    IconData? icon,
    BlueprintIntent intent = BlueprintIntent.none,
    BlueprintTagSize size = BlueprintTagSize.medium,
    VoidCallback? onTap,
  }) {
    return BlueprintTag(
      text: text,
      icon: icon,
      intent: intent,
      size: size,
      removable: true,
      interactive: onTap != null,
      onRemove: onRemove,
      onTap: onTap,
    );
  }

  static Widget round({
    required String text,
    IconData? icon,
    BlueprintIntent intent = BlueprintIntent.none,
    BlueprintTagSize size = BlueprintTagSize.medium,
    VoidCallback? onTap,
  }) {
    return BlueprintTag(
      text: text,
      icon: icon,
      intent: intent,
      size: size,
      round: true,
      interactive: onTap != null,
      onTap: onTap,
    );
  }

  static Widget interactive({
    required String text,
    required VoidCallback onTap,
    IconData? icon,
    BlueprintIntent intent = BlueprintIntent.none,
    BlueprintTagSize size = BlueprintTagSize.medium,
  }) {
    return BlueprintTag(
      text: text,
      icon: icon,
      intent: intent,
      size: size,
      interactive: true,
      onTap: onTap,
    );
  }

  static Widget withIntent({
    required String text,
    required BlueprintIntent intent,
    IconData? icon,
    BlueprintTagSize size = BlueprintTagSize.medium,
    bool minimal = false,
    VoidCallback? onTap,
  }) {
    return BlueprintTag(
      text: text,
      icon: icon,
      intent: intent,
      size: size,
      minimal: minimal,
      interactive: onTap != null,
      onTap: onTap,
    );
  }

  // Compound tag factory methods
  static Widget compound({
    required Widget leftContent,
    Widget? rightContent,
    IconData? icon,
    IconData? rightIcon,
    BlueprintIntent intent = BlueprintIntent.none,
    BlueprintTagSize size = BlueprintTagSize.medium,
    bool minimal = false,
    bool round = false,
    bool removable = false,
    bool interactive = false,
    bool fill = false,
    VoidCallback? onRemove,
    VoidCallback? onTap,
  }) {
    return BlueprintCompoundTag(
      leftContent: leftContent,
      rightContent: rightContent,
      icon: icon,
      rightIcon: rightIcon,
      intent: intent,
      size: size,
      minimal: minimal,
      round: round,
      removable: removable,
      interactive: interactive,
      fill: fill,
      onRemove: onRemove,
      onTap: onTap,
    );
  }

  static Widget compoundKeyValue({
    required String key,
    required String value,
    IconData? icon,
    IconData? rightIcon,
    BlueprintIntent intent = BlueprintIntent.none,
    BlueprintTagSize size = BlueprintTagSize.medium,
    bool minimal = false,
    bool removable = false,
    VoidCallback? onRemove,
    VoidCallback? onTap,
  }) {
    return BlueprintCompoundTag(
      leftContent: Text(key),
      rightContent: Text(value),
      icon: icon,
      rightIcon: rightIcon,
      intent: intent,
      size: size,
      minimal: minimal,
      removable: removable,
      interactive: onTap != null,
      onRemove: onRemove,
      onTap: onTap,
    );
  }
}