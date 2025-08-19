/// Shared enums, types, and utilities for Blueprint components
library blueprint_common;

import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';

// Re-export theme and colors for convenience
export 'package:flutter/material.dart';
export '../theme/blueprint_theme.dart';
export '../theme/blueprint_colors.dart';

/// Intent colors used across Blueprint components for semantic meaning
enum BlueprintIntent {
  none,
  primary,
  success,
  warning,
  danger,
}

/// Standard size options used across Blueprint components
enum BlueprintSize {
  small,
  normal,
  large,
}

/// Elevation levels for Blueprint cards and surfaces
enum BlueprintElevation {
  zero,
  one,
  two,
  three,
  four,
}

/// Common alignment options
enum BlueprintAlignment {
  left,
  center,
  right,
}

/// Position options for popovers, tooltips, and overlays
enum BlueprintPosition {
  auto,
  top,
  topStart,
  topEnd,
  bottom,
  bottomStart,
  bottomEnd,
  left,
  leftStart,
  leftEnd,
  right,
  rightStart,
  rightEnd,
}


/// Interaction modes for components
enum BlueprintInteraction {
  hover,
  click,
  focus,
  none,
}

/// Component variants for styling
enum BlueprintVariant {
  solid,
  minimal,
  outlined,
}

/// Button-specific variants (extends general BlueprintVariant)
enum BlueprintButtonVariant {
  solid,
  minimal,
  outlined,
}

/// Helper functions for intent colors
extension BlueprintIntentColors on BlueprintIntent {
  /// Get the primary color for this intent
  Color get color {
    switch (this) {
      case BlueprintIntent.primary:
        return BlueprintColors.intentPrimary;
      case BlueprintIntent.success:
        return BlueprintColors.intentSuccess;
      case BlueprintIntent.warning:
        return BlueprintColors.intentWarning;
      case BlueprintIntent.danger:
        return BlueprintColors.intentDanger;
      case BlueprintIntent.none:
        return BlueprintColors.gray3;
    }
  }

  /// Get the hover color for this intent
  Color get hoverColor {
    switch (this) {
      case BlueprintIntent.primary:
        return BlueprintColors.blue2;
      case BlueprintIntent.success:
        return BlueprintColors.green2;
      case BlueprintIntent.warning:
        return BlueprintColors.orange2;
      case BlueprintIntent.danger:
        return BlueprintColors.red2;
      case BlueprintIntent.none:
        return BlueprintColors.gray2;
    }
  }

  /// Get the active/pressed color for this intent
  Color get activeColor {
    switch (this) {
      case BlueprintIntent.primary:
        return BlueprintColors.blue4;
      case BlueprintIntent.success:
        return BlueprintColors.green4;
      case BlueprintIntent.warning:
        return BlueprintColors.orange4;
      case BlueprintIntent.danger:
        return BlueprintColors.red4;
      case BlueprintIntent.none:
        return BlueprintColors.gray4;
    }
  }
}

/// Helper functions for size values
extension BlueprintSizeValues on BlueprintSize {
  /// Get the padding value for this size
  double get padding {
    switch (this) {
      case BlueprintSize.small:
        return BlueprintTheme.gridSize * 0.5; // 5px
      case BlueprintSize.normal:
        return BlueprintTheme.gridSize; // 10px
      case BlueprintSize.large:
        return BlueprintTheme.gridSize * 1.5; // 15px
    }
  }

  /// Get the font size for this size
  double get fontSize {
    switch (this) {
      case BlueprintSize.small:
        return BlueprintTheme.fontSizeSmall;
      case BlueprintSize.normal:
        return BlueprintTheme.fontSize;
      case BlueprintSize.large:
        return BlueprintTheme.fontSizeLarge;
    }
  }

  /// Get the icon size for this size
  double get iconSize {
    switch (this) {
      case BlueprintSize.small:
        return BlueprintTheme.gridSize * 1.6; // 16px
      case BlueprintSize.normal:
        return BlueprintTheme.gridSize * 2.0; // 20px
      case BlueprintSize.large:
        return BlueprintTheme.gridSize * 2.4; // 24px
    }
  }
}

/// Helper functions for elevation shadows
extension BlueprintElevationShadows on BlueprintElevation {
  /// Get the box shadow for this elevation level
  List<BoxShadow> get shadows {
    switch (this) {
      case BlueprintElevation.zero:
        return [];
      case BlueprintElevation.one:
        return [
          BoxShadow(
            color: BlueprintColors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 0),
            blurRadius: 0,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: BlueprintColors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 1),
            blurRadius: 1,
          ),
        ];
      case BlueprintElevation.two:
        return [
          BoxShadow(
            color: BlueprintColors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 0),
            blurRadius: 0,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: BlueprintColors.black.withValues(alpha: 0.15),
            offset: const Offset(0, 1),
            blurRadius: 1,
          ),
          BoxShadow(
            color: BlueprintColors.black.withValues(alpha: 0.15),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ];
      case BlueprintElevation.three:
        return [
          BoxShadow(
            color: BlueprintColors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 0),
            blurRadius: 0,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: BlueprintColors.black.withValues(alpha: 0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
          BoxShadow(
            color: BlueprintColors.black.withValues(alpha: 0.2),
            offset: const Offset(0, 8),
            blurRadius: 24,
          ),
        ];
      case BlueprintElevation.four:
        return [
          BoxShadow(
            color: BlueprintColors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 0),
            blurRadius: 0,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: BlueprintColors.black.withValues(alpha: 0.2),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: BlueprintColors.black.withValues(alpha: 0.2),
            offset: const Offset(0, 18),
            blurRadius: 46,
          ),
        ];
    }
  }
}