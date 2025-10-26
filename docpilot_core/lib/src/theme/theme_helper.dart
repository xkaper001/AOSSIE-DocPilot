import 'package:flutter/material.dart';
import 'text_style.dart';

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

  // Neutral Light Colors
  static const Color neutralLightDarkest = Color(0xFFC5C6CC);
  static const Color neutralLightDark = Color(0xFFD4D6DD);
  static const Color neutralLightMedium = Color(0xFFE8E9F1);
  static const Color neutralLightLight = Color(0xFFF8F9FE);
  static const Color neutralLightLightest = Color(0xFFFFFFFF);

  // Neutral Dark Colors
  static const Color neutralDarkDarkest = Color(0xFF1F2024);
  static const Color neutralDarkDark = Color(0xFF2F3036);
  static const Color neutralDarkMedium = Color(0xFF494A50);
  static const Color neutralDarkLight = Color(0xFF71727A);
  static const Color neutralDarkLightest = Color(0xFF8F9098);

  // Success Colors
  static const Color successDark = Color(0xFF147D64);
  static const Color successMedium = Color(0xFF3AC0A0);
  static const Color successLight = Color(0xFFE7F4E8);

  // Warning Colors
  static const Color warningDark = Color(0xFFE86339);
  static const Color warningMedium = Color(0xFFFFB37C);
  static const Color warningLight = Color(0xFFFFF4E4);

  // Error Colors
  static const Color errorDark = Color(0xFFED3241);
  static const Color errorMedium = Color(0xFFFF616D);
  static const Color errorLight = Color(0xFFFFE2E5);

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
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingXLarge,
            vertical: spacingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusXLarge),
          ),
          elevation: 0,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(
            horizontal: spacingXLarge,
            vertical: spacingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusXLarge),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingMedium,
            vertical: spacingSmall,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusXLarge),
          ),
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primaryColor,
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        circularTrackColor: neutralLightMedium,
        strokeWidth: 5.0,
        strokeAlign: BorderSide.strokeAlignCenter,
        strokeCap: StrokeCap.round,
        circularTrackPadding: EdgeInsets.all(2.0),
        constraints: BoxConstraints(
          maxWidth: 32.0,
          maxHeight: 32.0,
          minHeight: 16.0,
          minWidth: 16.0,
        ),
        linearTrackColor: neutralLightMedium,
        linearMinHeight: 6,
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
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: neutralLightLightest,
        indicatorColor: neutralLightLightest,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return DocPilotTextStyles.actionM
                  .copyWith(color: neutralDarkDarkest);
            }
            return DocPilotTextStyles.bodyXS
                .copyWith(color: neutralDarkDarkest);
          },
        ),
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
