import 'package:docpilot_core/docpilot_core.dart';
import 'package:flutter/material.dart';

/// DocPilot Color Palette (Doctor App)
///
/// Centralized color definitions following the design system.
/// All colors should be accessed through this palette for consistency.
class Palette {
  // Prevent instantiation
  Palette._();

  // Primary Colors (Doctor App - Blue theme)
  static const Color primaryDarkest = Color(0xFF006FFD);
  static const Color primaryDark = Color(0xFF2897FF);
  static const Color primaryMedium = Color(0xFF6FBAFF);
  static const Color primaryLight = Color(0xFFB4DBFF);
  static const Color primaryLightest = Color(0xFFEAF2FF);

  // Neutral Light Colors
  static const Color neutralLightDarkest = ThemeHelper.neutralLightDarkest;
  static const Color neutralLightDark = ThemeHelper.neutralLightDark;
  static const Color neutralLightMedium = ThemeHelper.neutralLightMedium;
  static const Color neutralLightLight = ThemeHelper.neutralLightLight;
  static const Color neutralLightLightest = ThemeHelper.neutralLightLightest;

  // Neutral Dark Colors
  static const Color neutralDarkDarkest = ThemeHelper.neutralDarkDarkest;
  static const Color neutralDarkDark = ThemeHelper.neutralDarkDark;
  static const Color neutralDarkMedium = ThemeHelper.neutralDarkMedium;
  static const Color neutralDarkLight = ThemeHelper.neutralDarkLight;
  static const Color neutralDarkLightest = ThemeHelper.neutralDarkLightest;

  // Success Colors
  static const Color successDark = ThemeHelper.successDark;
  static const Color successMedium = ThemeHelper.successMedium;
  static const Color successLight = ThemeHelper.successLight;

  // Warning Colors
  static const Color warningDark = ThemeHelper.warningDark;
  static const Color warningMedium = ThemeHelper.warningMedium;
  static const Color warningLight = ThemeHelper.warningLight;

  // Error Colors
  static const Color errorDark = ThemeHelper.errorDark;
  static const Color errorMedium = ThemeHelper.errorMedium;
  static const Color errorLight = ThemeHelper.errorLight;

  // Semantic Colors (for easier access)
  static const Color primary = primaryDarkest;
  static const Color background = neutralLightLightest;
  static const Color surface = neutralLightLight;
  static const Color textPrimary = neutralDarkDarkest;
  static const Color textSecondary = neutralDarkDark;
  static const Color textDisabled = neutralDarkLightest;
  static const Color border = neutralLightDarkest;
  static const Color borderLight = neutralLightMedium;
  static const Color error = errorDark;
}
