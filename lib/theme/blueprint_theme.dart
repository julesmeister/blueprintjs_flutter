import 'package:flutter/material.dart';
import 'blueprint_colors.dart';

class BlueprintTheme {
  // Grid and dimensions
  static const double gridSize = 10.0;
  static const double borderRadius = 2.0;
  
  // Component heights
  static const double buttonHeight = gridSize * 3;
  static const double buttonHeightSmall = gridSize * 2.4;
  static const double buttonHeightLarge = gridSize * 4;
  
  // Typography
  static const double fontSize = gridSize * 1.4;
  static const double fontSizeLarge = gridSize * 1.6;
  static const double fontSizeSmall = gridSize * 1.2;
  
  // Elevations (shadows)
  static const List<BoxShadow> elevation0 = [];
  
  static const List<BoxShadow> elevation1 = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 1,
    ),
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 1),
      blurRadius: 1,
    ),
  ];
  
  static const List<BoxShadow> elevation2 = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 1,
    ),
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 1),
      blurRadius: 1,
    ),
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 2),
      blurRadius: 6,
    ),
  ];
  
  static const List<BoxShadow> elevation3 = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 1,
    ),
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 8),
      blurRadius: 24,
    ),
  ];
  
  static const List<BoxShadow> elevation4 = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 1,
    ),
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 4),
      blurRadius: 8,
    ),
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 18),
      blurRadius: 46,
      spreadRadius: 6,
    ),
  ];
  
  // Light theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: BlueprintColors.appBackgroundColor,
    colorScheme: const ColorScheme.light(
      primary: BlueprintColors.intentPrimary,
      secondary: BlueprintColors.intentPrimary,
      surface: BlueprintColors.appSecondaryBackgroundColor,
      background: BlueprintColors.appBackgroundColor,
      error: BlueprintColors.intentDanger,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: BlueprintColors.textColor,
      onBackground: BlueprintColors.textColor,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: fontSize,
        color: BlueprintColors.textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: fontSize,
        color: BlueprintColors.textColor,
      ),
      bodySmall: TextStyle(
        fontSize: fontSizeSmall,
        color: BlueprintColors.textColorMuted,
      ),
      headlineLarge: TextStyle(
        fontSize: fontSizeLarge,
        color: BlueprintColors.headingColor,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    ),
  );
  
  // Dark theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: BlueprintColors.darkAppBackgroundColor,
    colorScheme: const ColorScheme.dark(
      primary: BlueprintColors.intentPrimary,
      secondary: BlueprintColors.intentPrimary,
      surface: BlueprintColors.darkAppSecondaryBackgroundColor,
      background: BlueprintColors.darkAppBackgroundColor,
      error: BlueprintColors.intentDanger,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: BlueprintColors.darkTextColor,
      onBackground: BlueprintColors.darkTextColor,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: fontSize,
        color: BlueprintColors.darkTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: fontSize,
        color: BlueprintColors.darkTextColor,
      ),
      bodySmall: TextStyle(
        fontSize: fontSizeSmall,
        color: BlueprintColors.darkTextColorMuted,
      ),
      headlineLarge: TextStyle(
        fontSize: fontSizeLarge,
        color: BlueprintColors.darkHeadingColor,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}