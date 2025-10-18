import 'package:flutter/material.dart';

/// Helper utilities for building consistent theme configurations across DocPilot apps.
///
/// This class provides constants and helper methods that apps can use
/// to maintain consistent spacing, sizing, and border radius values.
class ThemeHelper {
  /// Spacing constants
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 12.0;
  static const double spacingLarge = 16.0;
  static const double spacingXLarge = 20.0;

  /// Border radius constants
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 12.0;
  static const double borderRadiusXLarge = 16.0;

  /// Input height
  static const double inputHeight = 48.0;

  /// Icon sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 20.0;
  static const double iconSizeLarge = 24.0;

  /// Border widths
  static const double borderWidthThin = 1.0;
  static const double borderWidthMedium = 1.5;
  static const double borderWidthThick = 2.0;

  /// Helper to get border width based on state
  static double getBorderWidth({
    required bool focused,
    required bool hasError,
  }) {
    if (hasError || focused) {
      return borderWidthThick;
    }
    return borderWidthMedium;
  }

  /// Helper to get text color based on enabled state
  static Color getTextColor(BuildContext context, bool enabled) {
    final theme = Theme.of(context);
    return enabled ? theme.colorScheme.onSurface : theme.disabledColor;
  }

  /// Helper to create a standard Material theme with custom primary color
  ///
  /// This is a convenience method for creating a consistent theme across apps.
  /// Each app should call this with their own primary color.
  ///
  /// Example:
  /// ```dart
  /// final theme = ThemeHelper.createAppTheme(
  ///   primaryColor: Color(0xFFD268CC), // Patient app purple
  ///   fontFamily: 'Inter',
  /// );
  /// ```
  static ThemeData createAppTheme({
    required Color primaryColor,
    String fontFamily = 'Inter',
    Brightness brightness = Brightness.light,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: primaryColor,
      fontFamily: fontFamily,
      
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
        // Customize specific colors
        primary: primaryColor,
      ),
      
      // Input decoration theme - no borders since components handle their own
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
      
      // Text theme with Inter font
      textTheme: TextTheme(
        // Display styles
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
        
        // Headline styles
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        
        // Title styles
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        
        // Body styles
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
        
        // Label styles
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}