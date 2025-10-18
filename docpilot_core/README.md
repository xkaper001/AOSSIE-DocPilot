# DocPilot Core - Shared Component Library

A Flutter package containing shared UI components, validators, and utilities used across DocPilot Doctor and Patient applications.

## Overview

This package provides a consistent set of form components, validators, and theme infrastructure that both DocPilot apps can use. It promotes:

- **Code Reusability**: Write once, use in both apps
- **Consistency**: Same behavior and appearance across apps
- **Maintainability**: Update components in one place
- **Theme Flexibility**: Components adapt to each app's theme

## Features

### 📝 Form Components
- `CustomTextField` - Single-line text input with validation
- `CustomTextArea` - Multi-line text input
- `CustomDropdown` - Dropdown selection field
- `CustomCheckbox` - Checkbox with multiple sizes
- `CustomDatePicker` - Date selection field

### ✅ Validators
- Email validation
- Password validation (strength checking)
- Phone number validation
- Required field validation
- Date validation (age restrictions, etc.)

### 🎨 Theme Infrastructure
- Base theme classes for app-specific customization
- Theme-aware components that adapt to app colors
- Standardized spacing, sizing, and styling

## Installation

Add this package to your app's `pubspec.yaml`:

```yaml
dependencies:
  docpilot_core:
    path: ../docpilot_core
```

Then run:
```bash
flutter pub get
```

## Usage

### Basic Import
```dart
import 'package:docpilot_core/docpilot_core.dart';
```

### Using Form Components

Components automatically adapt to your app's theme when properly configured:

```dart
// In your app, provide theme colors via Theme
MaterialApp(
  theme: ThemeData(
    primaryColor: Color(0xFF006FFD), // Your app's primary color
    // ... other theme properties
  ),
  home: MyForm(),
)

// Use components in your forms
CustomTextField(
  label: 'Email',
  placeholder: 'Enter your email',
  validator: FormValidators.email,
  onChanged: (value) => print(value),
)

CustomDropdown<String>(
  label: 'Country',
  items: ['USA', 'UK', 'Canada'],
  itemBuilder: (item) => item,
  onChanged: (value) => print(value),
)

CustomCheckbox(
  label: 'I agree to terms',
  value: agreedToTerms,
  onChanged: (value) => setState(() => agreedToTerms = value),
)
```

### Using Validators

```dart
CustomTextField(
  label: 'Email',
  validator: FormValidators.email,
)

CustomTextField(
  label: 'Password',
  validator: FormValidators.password,
  obscureText: true,
)

CustomTextField(
  label: 'Phone',
  validator: FormValidators.phoneNumber,
  keyboardType: TextInputType.phone,
)
```

## Component Documentation

### CustomTextField

Single-line text input with comprehensive validation support.

```dart
CustomTextField(
  label: 'Full Name',
  placeholder: 'Enter your full name',
  helperText: 'First and last name',
  validator: (value) => FormValidators.required(value, fieldName: 'Name'),
  onChanged: (value) => print(value),
  prefixIcon: Icon(Icons.person),
)
```

### CustomTextArea

Multi-line text input for longer content.

```dart
CustomTextArea(
  label: 'Description',
  placeholder: 'Enter description',
  minLines: 3,
  maxLines: 6,
  maxLength: 500,
)
```

### CustomDropdown

Dropdown menu with type-safe selection.

```dart
CustomDropdown<String>(
  label: 'Blood Type',
  items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'],
  itemBuilder: (item) => item,
  onChanged: (value) => print('Selected: $value'),
)
```

### CustomCheckbox

Checkbox with three size options.

```dart
CustomCheckbox(
  label: 'Subscribe to newsletter',
  value: subscribed,
  size: CheckboxSize.medium,
  onChanged: (value) => setState(() => subscribed = value),
)
```

### CustomDatePicker

Date picker optimized for date of birth and date selection.

```dart
CustomDatePicker(
  label: 'Date of Birth',
  placeholder: 'Select your date of birth',
  firstDate: DateTime(1900),
  lastDate: DateTime.now(),
  onDateSelected: (date) => print(date),
)
```

## Validators

### Available Validators

- `FormValidators.required(value, {fieldName})` - Required field validation
- `FormValidators.email(value)` - Email format validation
- `FormValidators.password(value)` - Password strength validation
- `FormValidators.phoneNumber(value)` - Phone number format validation
- `FormValidators.dateOfBirth(date, {minAge, maxAge})` - Date validation with age restrictions
- `FormValidators.minLength(value, minLength)` - Minimum length validation
- `FormValidators.maxLength(value, maxLength)` - Maximum length validation

### Custom Validation

You can also provide custom validators:

```dart
CustomTextField(
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (!value.contains('@company.com')) {
      return 'Must be a company email';
    }
    return null;
  },
)
```

## Theme Integration

Components automatically use colors from your app's `ThemeData`:

```dart
// In your app's theme setup
MaterialApp(
  theme: ThemeData(
    primaryColor: yourPrimaryColor,
    colorScheme: ColorScheme.light(
      primary: yourPrimaryColor,
      error: yourErrorColor,
    ),
    // Components will use these colors
  ),
)
```

Components look for theme colors in this order:
1. App's `Theme.of(context).primaryColor`
2. App's `Theme.of(context).colorScheme.primary`
3. Fallback to neutral colors

## Architecture

```
docpilot_core/
├── lib/
│   ├── docpilot_core.dart          # Main library export
│   └── src/
│       ├── widgets/
│       │   └── forms/
│       │       ├── custom_checkbox.dart
│       │       ├── custom_date_picker.dart
│       │       ├── custom_dropdown.dart
│       │       ├── custom_text_area.dart
│       │       ├── custom_text_field.dart
│       │       └── forms.dart
│       ├── validators/
│       │   └── form_validators.dart
│       └── theme/
│           └── app_theme_base.dart
├── pubspec.yaml
└── README.md
```

## Best Practices

1. **Always use validators**: Validate user input at the field level
2. **Provide labels**: Help users understand what's expected
3. **Use helper text**: Provide guidance without cluttering the UI
4. **Handle errors gracefully**: Show clear error messages
5. **Use appropriate input types**: `keyboardType`, `textInputAction`, etc.

## Examples

See the demo apps for complete examples:
- `docpilot_patient/lib/demo_forms_screen.dart`
- Form usage in both doctor and patient apps

## Contributing

When adding new components or validators:

1. Add to `lib/src/widgets/` or `lib/src/validators/`
2. Export from `lib/docpilot_core.dart`
3. Update this README with usage examples
4. Ensure components work with both app themes
5. Add documentation comments

## Version

Current version: 1.0.0

## License

See LICENSE file in the root directory.
