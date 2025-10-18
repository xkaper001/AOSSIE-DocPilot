import 'package:flutter/material.dart';

/// DocPilot Color Palette
/// 
/// Centralized color definitions following the design system.
/// All colors should be accessed through this palette for consistency.
class Palette {
  // Prevent instantiation
  Palette._();

  // Primary Colors (Patient App - Purple/Pink theme)
  static const Color primaryDarkest = Color(0xFFD268CC);
  static const Color primaryDark = Color(0xFFDB84D6);
  static const Color primaryMedium = Color(0xFFE5A0E0);
  static const Color primaryLight = Color(0xFFEFBCEB);
  static const Color primaryLightest = Color(0xFFF9D8F5);

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