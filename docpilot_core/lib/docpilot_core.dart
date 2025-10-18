/// DocPilot Core Library
/// 
/// Shared components, widgets, validators, and utilities used across
/// DocPilot Doctor and Patient applications.
/// 
/// This library provides:
/// - Form components (TextField, Dropdown, Checkbox, DatePicker, TextArea)
/// - Validators (email, password, phone, etc.)
/// - Base theme structure (AppTheme base class)
/// - Common utilities
/// 
/// ## Usage
/// 
/// Add to your app's `pubspec.yaml`:
/// ```yaml
/// dependencies:
///   docpilot_core:
///     path: ../docpilot_core
/// ```
/// 
/// Import in your code:
/// ```dart
/// import 'package:docpilot_core/docpilot_core.dart';
/// ```

library docpilot_core;

// Form widgets
export 'src/widgets/forms/forms.dart';

// Validators
export 'src/validators/form_validators.dart';

// Theme utilities
export 'src/theme/theme_helper.dart';

