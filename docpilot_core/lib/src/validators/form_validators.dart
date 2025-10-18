/// Form validation utilities for common input validation scenarios.
///
/// Provides reusable validators for text fields including:
/// - Required field validation
/// - Email format validation
/// - Phone number validation
/// - Password strength validation
/// - Custom validation rules
class FormValidators {
  /// Validates that a field is not empty.
  ///
  /// Returns an error message if the value is null or empty.
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates email format.
  ///
  /// Checks if the email matches a standard email pattern.
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validates phone number format.
  ///
  /// Accepts various phone number formats including international numbers.
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove common formatting characters
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');

    // Check if remaining characters are digits and length is reasonable
    if (cleaned.length < 10 || cleaned.length > 15) {
      return 'Please enter a valid phone number';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(cleaned)) {
      return 'Phone number can only contain digits';
    }

    return null;
  }

  /// Validates minimum length requirement.
  ///
  /// [minLength] - Minimum number of characters required
  static String? minLength(String? value, int minLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (value.length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters';
    }

    return null;
  }

  /// Validates maximum length requirement.
  ///
  /// [maxLength] - Maximum number of characters allowed
  static String? maxLength(String? value, int maxLength, {String? fieldName}) {
    if (value != null && value.length > maxLength) {
      return '${fieldName ?? 'This field'} must not exceed $maxLength characters';
    }

    return null;
  }

  /// Validates password strength.
  ///
  /// Requires at least 8 characters with a mix of uppercase, lowercase, and numbers.
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  /// Validates that two values match (e.g., password confirmation).
  ///
  /// [value] - The value to validate
  /// [matchValue] - The value it should match
  static String? match(String? value, String? matchValue, {String? fieldName}) {
    if (value != matchValue) {
      return '${fieldName ?? 'This field'} does not match';
    }
    return null;
  }

  /// Validates numeric input.
  ///
  /// Ensures the value contains only numbers.
  static String? numeric(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return '${fieldName ?? 'This field'} must contain only numbers';
    }

    return null;
  }

  /// Validates a numeric range.
  ///
  /// [min] - Minimum value (inclusive)
  /// [max] - Maximum value (inclusive)
  static String? range(String? value, num min, num max, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    final numValue = num.tryParse(value);
    if (numValue == null) {
      return '${fieldName ?? 'This field'} must be a valid number';
    }

    if (numValue < min || numValue > max) {
      return '${fieldName ?? 'This field'} must be between $min and $max';
    }

    return null;
  }

  /// Validates date of birth.
  ///
  /// Ensures the person is at least [minAge] years old.
  static String? dateOfBirth(DateTime? value, {int minAge = 0}) {
    if (value == null) {
      return 'Date of birth is required';
    }

    final today = DateTime.now();
    if (value.isAfter(today)) {
      return 'Date of birth cannot be in the future';
    }
    int age = today.year - value.year;
    final hasHadBirthdayThisYear = (today.month > value.month) ||
        (today.month == value.month && today.day >= value.day);
    if (!hasHadBirthdayThisYear) age--;
    if (age < minAge) {
      return 'You must be at least $minAge years old';
    }

    return null;
  }

  /// Combines multiple validators.
  ///
  /// Runs each validator in sequence and returns the first error found.
  static String? compose(
    List<String? Function(String?)> validators,
    String? value,
  ) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) {
        return error;
      }
    }
    return null;
  }
}
