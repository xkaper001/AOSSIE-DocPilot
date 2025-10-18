# DocPilot Theme System

This document describes the centralized theme system for the DocPilot Patient app, including the color palette and common styling configurations.

## Overview

The theme system consists of two main files:
- **`palette.dart`** - Centralized color definitions
- **`app_theme.dart`** - Text styles, spacing, sizing, and Material theme configuration
- **`theme.dart`** - Export file for convenient imports

## Quick Start

Import the theme system in your files:

```dart
import 'package:docpilot_patient/core/theme/theme.dart';
```

This gives you access to both `Palette` and `AppTheme` classes.

## Color Palette (`Palette`)

All colors are defined in the `Palette` class and should be used throughout the app for consistency.

### Primary Colors
```dart
Palette.primaryDarkest   // #006FFD - Main brand color
Palette.primaryDark      // #2897FF
Palette.primaryMedium    // #6FBAFF
Palette.primaryLight     // #B4DBFF
Palette.primaryLightest  // #EAF2FF
```

### Neutral Light Colors (Backgrounds, Borders)
```dart
Palette.neutralLightDarkest   // #C5C6CC - Dark borders
Palette.neutralLightDark      // #D4D6DD
Palette.neutralLightMedium    // #E8E9F1 - Light borders
Palette.neutralLightLight     // #F8F9FE - Surface backgrounds
Palette.neutralLightLightest  // #FFFFFF - White
```

### Neutral Dark Colors (Text)
```dart
Palette.neutralDarkDarkest   // #1F2024 - Primary text
Palette.neutralDarkDark      // #2F3036 - Secondary text
Palette.neutralDarkMedium    // #494A50
Palette.neutralDarkLight     // #71727A
Palette.neutralDarkLightest  // #8F9098 - Disabled text, placeholders
```

### Status Colors

#### Success
```dart
Palette.successDark      // #147D64
Palette.successMedium    // #3AC0A0
Palette.successLight     // #E7F4E8
```

#### Warning
```dart
Palette.warningDark      // #E86339
Palette.warningMedium    // #FFB37C
Palette.warningLight     // #FFF4E4
```

#### Error
```dart
Palette.errorDark        // #ED3241
Palette.errorMedium      // #FF616D
Palette.errorLight       // #FFE2E5
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

## App Theme (`AppTheme`)

The `AppTheme` class provides centralized styling configurations.

### Text Styles

#### Labels (for input labels, section headers)
```dart
AppTheme.labelLarge      // 12px, Bold, for input labels
AppTheme.labelMedium     // 12px, Bold, with line height
AppTheme.labelSmall      // 10px, Regular
```

#### Body Text
```dart
AppTheme.bodyLarge       // 16px, Regular
AppTheme.bodyMedium      // 14px, Regular (most common)
AppTheme.bodySmall       // 12px, Regular
```

#### Specialized Text Styles
```dart
AppTheme.helperText      // Helper text below inputs
AppTheme.errorText       // Error messages
AppTheme.placeholder     // Placeholder text in inputs
AppTheme.inputText       // Text inside inputs (enabled)
AppTheme.inputTextDisabled  // Text inside inputs (disabled)
AppTheme.buttonTextLarge    // 16px, Semi-bold for buttons
AppTheme.buttonTextMedium   // 14px, Semi-bold for buttons
```

### Spacing Constants

Use these instead of hardcoded pixel values:

```dart
AppTheme.spacingXSmall   // 4px
AppTheme.spacingSmall    // 8px
AppTheme.spacingMedium   // 12px
AppTheme.spacingLarge    // 16px
AppTheme.spacingXLarge   // 20px
```

### Border Radius Constants

```dart
AppTheme.borderRadiusSmall   // 4px
AppTheme.borderRadiusMedium  // 6px
AppTheme.borderRadiusLarge   // 8px
AppTheme.borderRadiusXLarge  // 12px - Used for most inputs/buttons
```

### Border Width Constants

```dart
AppTheme.borderWidthThin     // 1.0px - Default border
AppTheme.borderWidthMedium   // 1.5px - Focused border
```

### Component Sizes

```dart
AppTheme.inputHeight         // 48px - Standard input height
AppTheme.iconSizeSmall       // 12px
AppTheme.iconSizeMedium      // 16px
AppTheme.iconSizeLarge       // 20px
AppTheme.iconSizeXLarge      // 24px
```

### Helper Methods

#### Get Border Color
```dart
Color borderColor = AppTheme.getBorderColor(
  enabled: true,
  focused: false,
  hasError: false,
);
```

#### Get Border Width
```dart
double borderWidth = AppTheme.getBorderWidth(
  focused: false,
  hasError: false,
);
```

#### Get Text Color
```dart
Color textColor = AppTheme.getTextColor(true); // enabled
```

#### Get Label Color
```dart
Color labelColor = AppTheme.getLabelColor(true); // enabled
```

## Material Theme

The `AppTheme.lightTheme` provides a complete MaterialApp theme with all the styling pre-configured:

```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  home: MyHomePage(),
)
```

This includes:
- Color scheme with primary colors
- Text theme with all text styles
- Input decoration theme
- Button themes (Elevated, Outlined, Text buttons)
- AppBar theme

## Usage Examples

### Using Colors in Widgets

```dart
Container(
  color: Palette.surface,
  child: Text(
    'Hello',
    style: AppTheme.bodyMedium.copyWith(
      color: Palette.primary,
    ),
  ),
)
```

### Using Spacing

```dart
Column(
  children: [
    Text('First'),
    SizedBox(height: AppTheme.spacingMedium),
    Text('Second'),
    SizedBox(height: AppTheme.spacingLarge),
    Text('Third'),
  ],
)
```

### Using Border Radius

```dart
Container(
  decoration: BoxDecoration(
    color: Palette.surface,
    borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
    border: Border.all(
      color: Palette.border,
      width: AppTheme.borderWidthThin,
    ),
  ),
  child: Text('Rounded container'),
)
```

### Using Icons with Theme Colors

```dart
Icon(
  Icons.check,
  size: AppTheme.iconSizeMedium,
  color: Palette.primary,
)
```

## Best Practices

1. **Always use Palette colors** - Never hardcode color values like `Color(0xFF...)` or `Colors.blue`
2. **Use AppTheme spacing** - Use spacing constants instead of hardcoded pixel values
3. **Use AppTheme text styles** - Use predefined text styles and `.copyWith()` when you need variations
4. **Use semantic color aliases** - Prefer `Palette.primary` over `Palette.primaryDarkest` for common use cases
5. **Use helper methods** - Use `AppTheme.getBorderColor()` and similar methods for state-based styling
6. **Leverage the Material theme** - The theme is pre-configured for buttons, inputs, etc.

## Migration Guide

To migrate existing code to use the theme system:

### Before
```dart
Container(
  height: 48,
  decoration: BoxDecoration(
    color: const Color(0xFFF8F9FE),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Text(
    'Hello',
    style: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      color: Color(0xFF1F2024),
    ),
  ),
)
```

### After
```dart
Container(
  height: AppTheme.inputHeight,
  decoration: BoxDecoration(
    color: Palette.surface,
    borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
  ),
  child: Text(
    'Hello',
    style: AppTheme.bodyMedium,
  ),
)
```

## Adding New Colors or Styles

If you need to add new colors or styles:

1. **For colors**: Add them to the appropriate section in `palette.dart`
2. **For text styles**: Add them to the text styles section in `app_theme.dart`
3. **For spacing/sizing**: Add constants to the appropriate section in `app_theme.dart`
4. **Update this README** with the new additions

## Component Usage

All form components (`CustomTextField`, `CustomDropdown`, `CustomCheckbox`, etc.) already use the theme system internally. When creating new components, follow their pattern:

```dart
import '../../theme/palette.dart';
import '../../theme/app_theme.dart';

class MyCustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
      ),
      child: Text(
        'Custom Widget',
        style: AppTheme.bodyMedium,
      ),
    );
  }
}
```

## Questions?

For questions or suggestions about the theme system, please refer to the [CONTRIBUTING.md](../../../CONTRIBUTING.md) file or reach out to the team.
