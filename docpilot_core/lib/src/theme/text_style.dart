import 'package:flutter/material.dart';

/// DocPilot Text Styles
/// All text styles following the Figma design system
class DocPilotTextStyles {
  // Private constructor to prevent instantiation
  DocPilotTextStyles._();

  // Font family
  static const String _fontFamily = 'Inter';

  // ==================== HEADING STYLES ====================

  /// Heading 1 - Extra Bold / 24
  /// Font weight: 800, Size: 24, Line height: 1.0 (100%)
  static const TextStyle h1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w800, // Extra Bold
    height: 1.0, // 100% line height
    letterSpacing: 0.24,
    color: Color(0xFF1F1F1F),
  );

  /// Heading 2 - Extra Bold / 18
  /// Font weight: 800, Size: 18, Line height: 1.0 (100%)
  static const TextStyle h2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w800, // Extra Bold
    height: 1.0, // 100% line height
    letterSpacing: 0.09,
    color: Color(0xFF1F1F1F),
  );

  /// Heading 3 - Extra Bold / 16
  /// Font weight: 800, Size: 16, Line height: 1.0 (100%)
  static const TextStyle h3 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w800, // Extra Bold
    height: 1.0, // 100% line height
    letterSpacing: 0.08,
    color: Color(0xFF1F1F1F),
  );

  /// Heading 4 - Bold / 14
  /// Font weight: 700, Size: 14, Line height: 1.0 (100%)
  static const TextStyle h4 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w700, // Bold
    height: 1.0, // 100% line height
    color: Color(0xFF1F1F1F),
  );

  /// Heading 5 - Bold / 12
  /// Font weight: 700, Size: 12, Line height: 1.0 (100%)
  static const TextStyle h5 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700, // Bold
    height: 1.0, // 100% line height
    color: Color(0xFF1F1F1F),
  );

  // ==================== BODY STYLES ====================

  /// Body XL - Regular / 18
  /// Font weight: 400, Size: 18, Line height: 24
  static const TextStyle bodyXL = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400, // Regular
    height: 24 / 18, // Line height: 24px
    color: Color(0xFF1F1F1F),
  );

  /// Body L - Regular / 16
  /// Font weight: 400, Size: 16, Line height: 22
  static const TextStyle bodyL = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    height: 22 / 16, // Line height: 22px
    color: Color(0xFF1F1F1F),
  );

  /// Body M - Regular / 14
  /// Font weight: 400, Size: 14, Line height: 20
  static const TextStyle bodyM = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
    height: 20 / 14, // Line height: 20px
    color: Color(0xFF1F1F1F),
  );

  /// Body S - Regular / 12
  /// Font weight: 400, Size: 12, Line height: 16
  static const TextStyle bodyS = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    height: 16 / 12, // Line height: 16px
    letterSpacing: 0.12,
    color: Color(0xFF1F1F1F),
  );

  /// Body XS - Regular / 10
  /// Font weight: 400, Size: 10, Line height: 14
  static const TextStyle bodyXS = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400, // Regular
    height: 14 / 10, // Line height: 14px
    letterSpacing: 0.15,
    color: Color(0xFF1F1F1F),
  );

  // ==================== ACTION STYLES ====================

  /// Action L - Semi Bold / 14
  /// Font weight: 600, Size: 14, Line height: 1.0 (100%)
  static const TextStyle actionL = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600, // Semi Bold
    height: 1.0, // 100% line height
    color: Color(0xFF1F1F1F),
  );

  /// Action M - Semi Bold / 12
  /// Font weight: 600, Size: 12, Line height: 1.0 (100%)
  static const TextStyle actionM = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600, // Semi Bold
    height: 1.0, // 100% line height
    color: Color(0xFF1F1F1F),
  );

  /// Action S - Semi Bold / 10
  /// Font weight: 600, Size: 10, Line height: 1.0 (100%)
  static const TextStyle actionS = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w600, // Semi Bold
    height: 1.0, // 100% line height
    color: Color(0xFF1F1F1F),
  );

  // ==================== CAPTION STYLES ====================

  /// Caption M - Semi Bold / 10 (Uppercase)
  /// Font weight: 600, Size: 10, Line height: 1.0 (100%)
  /// Note: Text should be transformed to uppercase when using this style
  static const TextStyle captionM = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w600, // Semi Bold
    height: 1.0, // 100% line height
    letterSpacing: 0.5,
    color: Color(0xFF1F1F1F),
  );

  // ==================== COLOR VARIANTS ====================

  // Helper methods to apply different color variants to text styles

  /// Apply dark color (#1F2024) to any text style
  static TextStyle withDarkColor(TextStyle style) {
    return style.copyWith(color: const Color(0xFF1F2024));
  }

  /// Apply medium dark color (#494A50) to any text style
  static TextStyle withMediumDarkColor(TextStyle style) {
    return style.copyWith(color: const Color(0xFF494A50));
  }

  /// Apply light dark color (#71727A) to any text style
  static TextStyle withLightDarkColor(TextStyle style) {
    return style.copyWith(color: const Color(0xFF71727A));
  }

  /// Apply lightest dark color (#8F9098) to any text style
  static TextStyle withLightestDarkColor(TextStyle style) {
    return style.copyWith(color: const Color(0xFF8F9098));
  }

  /// Apply highlight color (#006FFD) to any text style
  static TextStyle withHighlightColor(TextStyle style) {
    return style.copyWith(color: const Color(0xFF006FFD));
  }

  /// Apply white color to any text style
  static TextStyle withWhiteColor(TextStyle style) {
    return style.copyWith(color: const Color(0xFFFFFFFF));
  }
}
