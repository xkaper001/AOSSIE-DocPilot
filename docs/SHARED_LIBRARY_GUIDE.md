# Shared Component Library Migration Guide

This document describes the shared component library architecture for DocPilot Doctor and Patient apps.

## Overview

The DocPilot project now uses a shared library (`docpilot_core`) that contains:
- **Form Components**: Reusable UI widgets (checkbox, text field, dropdown, etc.)
- **Validators**: Form validation utilities
- **Theme Helpers**: Utilities for consistent theming

This approach eliminates code duplication while allowing each app to maintain its own theme colors.

## Architecture

```
DocPilot/
├── docpilot_core/              # Shared component library
│   ├── lib/
│   │   ├── docpilot_core.dart  # Main export file
│   │   └── src/
│   │       ├── widgets/forms/  # Form components
│   │       ├── validators/     # Form validators
│   │       └── theme/          # Theme utilities
│   └── pubspec.yaml
│
├── docpilot_patient/           # Patient app (Purple theme #D268CC)
│   ├── lib/
│   │   ├── core/theme/         # Patient-specific theme
│   │   └── ...
│   └── pubspec.yaml            # Depends on docpilot_core
│
└── docpilot_doctor/            # Doctor app (Blue theme #006FFD)
    ├── lib/
    │   ├── core/theme/         # Doctor-specific theme
    │   └── ...
    └── pubspec.yaml            # Depends on docpilot_core
```

## Key Principles

### 1. Theme-Agnostic Components

Components in `docpilot_core` don't hardcode colors. Instead, they use Flutter's Theme system:

```dart
// ❌ OLD WAY (hardcoded colors)
Container(
  decoration: BoxDecoration(
    border: Border.all(color: Color(0xFFD268CC)), // Hardcoded
  ),
)

// ✅ NEW WAY (theme-aware)
Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: Theme.of(context).primaryColor, // From app theme
    ),
  ),
)
```

### 2. Single Source of Truth

- **Spacing, sizing, border radius**: Defined in `ThemeHelper` (docpilot_core)
- **App colors**: Defined in each app's `Palette` class
- **Material theme**: Built using `ThemeHelper.createAppTheme()` with app-specific colors

### 3. No Local Duplicates

With the shared library, apps should:
- ✅ Import components from `docpilot_core`
- ❌ NOT create their own `CustomTextField`, `CustomCheckbox`, etc.
- ✅ Keep their own `Palette` and `AppTheme` for app-specific colors

## Usage Guide

### For Component Developers

When creating shared components in `docpilot_core`:

```dart
import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      // ✅ Use theme colors
      color: theme.primaryColor,
      
      // ✅ Use theme text styles
      child: Text('Hello', style: theme.textTheme.bodyLarge),
      
      // ✅ Use ThemeHelper constants
      padding: EdgeInsets.all(ThemeHelper.spacingMedium),
    );
  }
}
```

### For App Developers

When using shared components in patient or doctor apps:

```dart
import 'package:flutter/material.dart';
import 'package:docpilot_core/docpilot_core.dart';

class MyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Components automatically use your app's theme
        CustomTextField(
          label: 'Email',
          validator: FormValidators.email,
        ),
        
        CustomCheckbox(
          label: 'I agree',
          value: true,
          onChanged: (val) {},
        ),
      ],
    );
  }
}
```

### Setting Up App Theme

Each app creates its theme using `ThemeHelper`:

```dart
// In docpilot_patient/lib/core/theme/app_theme.dart
import 'package:docpilot_core/docpilot_core.dart';
import 'palette.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final baseTheme = ThemeHelper.createAppTheme(
      primaryColor: Palette.primary, // App-specific color
      fontFamily: 'Inter',
    );
    
    return baseTheme.copyWith(
      scaffoldBackgroundColor: Palette.background,
      // ... other app-specific customizations
    );
  }
}
```

## Benefits

### 1. Code Reusability
- Write form components once, use in both apps
- Reduced maintenance burden
- Fewer bugs (single implementation to test)

### 2. Consistency
- Same behavior across both apps
- Uniform validation rules
- Consistent spacing and sizing

### 3. Theme Flexibility
- Each app keeps its own colors
- Components adapt automatically
- Easy to add more apps in the future

### 4. Simplified Updates
- Update a component in one place
- Both apps benefit immediately
- No need to sync changes between apps

## Components Available

### Form Widgets

| Component | Description | Key Features |
|-----------|-------------|--------------|
| `CustomTextField` | Single-line text input | Validation, icons, auto-focus |
| `CustomTextArea` | Multi-line text input | Min/max lines, character counter |
| `CustomDropdown<T>` | Dropdown selector | Type-safe, custom item builder |
| `CustomCheckbox` | Checkbox with label | 3 sizes (small/medium/large) |
| `CustomDatePicker` | Date selection | Date validation, range limits |

### Validators

| Validator | Usage |
|-----------|-------|
| `FormValidators.required()` | Ensure field is not empty |
| `FormValidators.email()` | Validate email format |
| `FormValidators.phone()` | Validate phone number |
| `FormValidators.password()` | Check password strength |
| `FormValidators.dateOfBirth()` | Validate date with age limits |
| `FormValidators.minLength()` | Minimum character length |
| `FormValidators.maxLength()` | Maximum character length |
| `FormValidators.compose()` | Combine multiple validators |

### Theme Utilities

| Utility | Purpose |
|---------|---------|
| `ThemeHelper.createAppTheme()` | Build consistent Material theme |
| `ThemeHelper.spacingXSmall` to `spacingXLarge` | Standard spacing values (4-20px) |
| `ThemeHelper.borderRadius*` | Border radius constants |
| `ThemeHelper.getBorderWidth()` | Get border width by state |

## Migration Checklist

If you're migrating existing code to use the shared library:

- [ ] Add `docpilot_core` dependency to `pubspec.yaml`
- [ ] Run `flutter pub get`
- [ ] Replace local form component imports with `import 'package:docpilot_core/docpilot_core.dart';`
- [ ] Update `AppTheme` to use `ThemeHelper.createAppTheme()`
- [ ] Remove local duplicate component files
- [ ] Test that theme colors work correctly (purple for patient, blue for doctor)
- [ ] Verify form validation still works
- [ ] Check that all forms display correctly

## Examples

See these files for complete examples:
- `docpilot_patient/lib/demo_forms_screen.dart` - All form components in action
- `docpilot_patient/lib/core/theme/app_theme.dart` - Patient app theme setup
- `docpilot_doctor/lib/core/theme/app_theme.dart` - Doctor app theme setup
- `docpilot_core/README.md` - Complete API documentation

## Future Enhancements

Potential additions to the shared library:
- Common screens (splash, onboarding)
- Network utilities
- Data models
- API clients
- Common widgets (cards, buttons, badges)
- Animation utilities
- Responsive design helpers

## Questions?

For questions about:
- **Component usage**: See `docpilot_core/README.md`
- **Theme customization**: See app-specific `app_theme.dart` files
- **Validation**: See `form_validators.dart` source code
- **Contributing**: See `CONTRIBUTING.md` in the root directory
