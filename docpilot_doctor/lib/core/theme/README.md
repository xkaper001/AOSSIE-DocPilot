# DocPilot Theme System (Doctor App)

This document describes the centralized theme system for the DocPilot Doctor app, including the color palette and common styling configurations.

## Overview

The theme system consists of three main files:
- **`palette.dart`** - Centralized color definitions (Blue theme for doctors)
- **`app_theme.dart`** - Text styles, spacing, sizing, and Material theme configuration
- **`theme.dart`** - Export file for convenient imports

## Quick Start

Import the theme system in your files:

```dart
import 'package:docpilot_doctor/core/theme/theme.dart';
```

This gives you access to both `Palette` and `AppTheme` classes.

## Color Palette (`Palette`)

All colors are defined in the `Palette` class and should be used throughout the app for consistency.

### Primary Colors (Blue Theme - Doctor App)
```dart
Palette.primaryDarkest   // #006FFD - Main brand color (Blue)
Palette.primaryDark      // #2897FF
Palette.primaryMedium    // #6FBAFF
Palette.primaryLight     // #B4DBFF
Palette.primaryLightest  // #EAF2FF
```

### Semantic Color Aliases

For easier access to commonly used colors:

```dart
Palette.primary          // Same as primaryDarkest
Palette.background       // White background
Palette.surface          // Light surface backgrounds
Palette.textPrimary      // Primary text color
Palette.textSecondary    // Secondary text color
Palette.textDisabled     // Disabled text color
Palette.border           // Default border color
Palette.borderLight      // Light border color (disabled states)
Palette.error            // Error color
```

For complete color documentation, see the patient app's theme README.

## App Theme (`AppTheme`)

The `AppTheme` class provides centralized styling configurations.

### Usage Examples

#### Using Colors
```dart
Container(
  color: Palette.primary,
  child: Text(
    'Doctor Dashboard',
    style: AppTheme.bodyLarge,
  ),
)
```

#### Using Spacing
```dart
Padding(
  padding: EdgeInsets.all(AppTheme.spacingLarge),
  child: Column(
    children: [
      Text('Patient Name'),
      SizedBox(height: AppTheme.spacingMedium),
      Text('Diagnosis'),
    ],
  ),
)
```

#### Using the Material Theme
```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  home: DoctorDashboard(),
)
```

## App Differentiation

### Doctor App (Blue Theme)
- Primary Color: **#006FFD** (Blue)
- Use case: Medical professionals, clinical interface
- Professional and trustworthy appearance

### Patient App (Purple/Pink Theme)
- Primary Color: **#D268CC** (Purple/Pink)
- Use case: Patient-facing interface
- Warm and welcoming appearance

## Best Practices

1. **Always use Palette colors** - Never hardcode color values
2. **Use AppTheme spacing** - Use spacing constants instead of hardcoded values
3. **Use AppTheme text styles** - Use predefined text styles and `.copyWith()` for variations
4. **Leverage the Material theme** - The theme is pre-configured for buttons, inputs, etc.

## Component Development

When creating new components, follow this pattern:

```dart
import 'package:docpilot_doctor/core/theme/theme.dart';

class CustomDoctorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
        border: Border.all(
          color: Palette.border,
          width: AppTheme.borderWidthThin,
        ),
      ),
      child: Text(
        'Patient Information',
        style: AppTheme.bodyMedium,
      ),
    );
  }
}
```

## Resources

For detailed documentation on:
- Text styles
- Spacing constants
- Border radius values
- Helper methods
- Complete color palette

See the comprehensive theme documentation in the patient app's theme README or the main THEME_REFACTORING.md document.
