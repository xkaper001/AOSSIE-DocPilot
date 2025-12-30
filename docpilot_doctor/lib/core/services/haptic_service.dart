import 'package:flutter/services.dart';

/// Service for managing haptic feedback throughout the application
class HapticService {
  HapticService._();
  static final HapticService instance = HapticService._();

  Future<void> lightImpact() async {
    await HapticFeedback.lightImpact();
  }

  Future<void> mediumImpact() async {
    await HapticFeedback.mediumImpact();
  }

  Future<void> heavyImpact() async {
    await HapticFeedback.heavyImpact();
  }

  Future<void> selectionClick() async {
    await HapticFeedback.selectionClick();
  }

  Future<void> success() async {
    await lightImpact();
  }

  Future<void> error() async {
    await heavyImpact();
    await heavyImpact();
    await heavyImpact();
  }

  Future<void> warning() async {
    await mediumImpact();
  }
}
