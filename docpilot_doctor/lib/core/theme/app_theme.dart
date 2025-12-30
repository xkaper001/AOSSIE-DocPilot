import 'package:flutter/material.dart';
import 'package:docpilot_core/docpilot_core.dart';
import 'palette.dart';

/// DocPilot Doctor Application Theme
///
/// Centralized theme configuration for the doctor app.
/// Uses the shared ThemeHelper from docpilot_core for consistent styling.
class AppTheme {
  // Prevent instantiation
  AppTheme._();

  // Font Family
  static const String fontFamily = 'Inter';

  /// Convenience accessors for spacing values from ThemeHelper
  static const double spacingXSmall = ThemeHelper.spacingXSmall;
  static const double spacingSmall = ThemeHelper.spacingSmall;
  static const double spacingMedium = ThemeHelper.spacingMedium;
  static const double spacingLarge = ThemeHelper.spacingLarge;
  static const double spacingXLarge = ThemeHelper.spacingXLarge;

  /// Border radius accessors
  static const double borderRadiusSmall = ThemeHelper.borderRadiusSmall;
  static const double borderRadiusMedium = ThemeHelper.borderRadiusMedium;
  static const double borderRadiusLarge = ThemeHelper.borderRadiusLarge;
  static const double borderRadiusXLarge = ThemeHelper.borderRadiusXLarge;

  /// Input height
  static const double inputHeight = ThemeHelper.inputHeight;

  /// Icon sizes
  static const double iconSizeSmall = ThemeHelper.iconSizeSmall;
  static const double iconSizeMedium = ThemeHelper.iconSizeMedium;
  static const double iconSizeLarge = ThemeHelper.iconSizeLarge;

  /// Border widths
  static const double borderWidthThin = ThemeHelper.borderWidthThin;
  static const double borderWidthMedium = ThemeHelper.borderWidthMedium;

  /// Text Styles

  // Label Styles (for input labels, section headers)
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Palette.neutralDarkDark,
    height: 1.0,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Palette.neutralDarkDark,
    height: 16 / 12,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 14 / 10,
    letterSpacing: 0.15,
  );

  // Body Text Styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Palette.textPrimary,
    height: 24 / 16,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Palette.textPrimary,
    height: 20 / 14,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Palette.textPrimary,
    height: 16 / 12,
  );

  // Helper Text Style
  static const TextStyle helperText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Palette.neutralDarkLightest,
    height: 14 / 10,
    letterSpacing: 0.15,
  );

  // Error Text Style
  static const TextStyle errorText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Palette.error,
    height: 14 / 10,
    letterSpacing: 0.15,
  );

  // Placeholder Text Style
  static const TextStyle placeholder = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Palette.neutralDarkLightest,
    height: 20 / 14,
  );

  // Input Text Style
  static const TextStyle inputText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Palette.textPrimary,
    height: 20 / 14,
  );

  // Disabled Input Text Style
  static const TextStyle inputTextDisabled = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Palette.textDisabled,
    height: 20 / 14,
  );

  // Button Text Styles
  static const TextStyle buttonTextLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle buttonTextMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  /// Helper Methods

  /// Get border color based on state
  static Color getBorderColor({
    required bool enabled,
    required bool focused,
    bool hasError = false,
  }) {
    if (!enabled) return Palette.borderLight;
    if (hasError) return Palette.error;
    if (focused) return Palette.primary;
    return Palette.border;
  }

  /// Get border width based on state
  static double getBorderWidth({required bool focused, bool hasError = false}) {
    return (focused && !hasError) ? borderWidthMedium : borderWidthThin;
  }

  /// Get text color based on enabled state
  static Color getTextColor(bool enabled) {
    return enabled ? Palette.textPrimary : Palette.textDisabled;
  }

  /// Get label text color based on enabled state
  static Color getLabelColor(bool enabled) {
    return enabled ? Palette.neutralDarkDark : Palette.textDisabled;
  }

  /// MaterialApp Theme Data
  /// Uses ThemeHelper from docpilot_core with Doctor app specific primary color (blue)
  static ThemeData get lightTheme {
    // Get base theme from ThemeHelper with doctor app primary color
    final baseTheme = ThemeHelper.createAppTheme(
      primaryColor: Palette.primary,
      fontFamily: fontFamily,
    );

    // Customize with doctor app specific colors
    return baseTheme.copyWith();
  }
}
