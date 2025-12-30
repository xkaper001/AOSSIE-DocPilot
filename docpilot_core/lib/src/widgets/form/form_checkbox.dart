import 'package:flutter/material.dart';

/// Size options for FormCheckbox
enum CheckboxSize {
  /// Small checkbox (16x16)
  small,

  /// Medium checkbox (24x24)
  medium,

  /// Large checkbox (32x32)
  large,
}

/// A custom checkbox component with multiple size options.
///
/// This component automatically adapts to the app's theme colors.
/// It uses Theme.of(context).primaryColor for the checked state.
///
/// Features:
/// - Three sizes: small (16px), medium (24px), large (32px)
/// - Selected and unselected states
/// - Optional label text
/// - Theme-aware colors
/// - Form validation support
///
/// Example:
/// ```dart
/// FormCheckbox(
///   label: 'I agree to the terms and conditions',
///   size: CheckboxSize.medium,
///   value: isChecked,
///   onChanged: (value) => setState(() => isChecked = value),
/// )
/// ```
class FormCheckbox extends StatelessWidget {
  /// Whether the checkbox is checked
  final bool value;

  /// Called when the checkbox state changes
  final ValueChanged<bool>? onChanged;

  /// Label text displayed next to checkbox
  final String? label;

  /// Size of the checkbox
  final CheckboxSize size;

  /// Whether the checkbox is enabled
  final bool enabled;

  /// Focus node for managing focus
  final FocusNode? focusNode;

  const FormCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.size = CheckboxSize.medium,
    this.enabled = true,
    this.focusNode,
  });

  double _getSize() {
    switch (size) {
      case CheckboxSize.small:
        return 16.0;
      case CheckboxSize.medium:
        return 24.0;
      case CheckboxSize.large:
        return 32.0;
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case CheckboxSize.small:
        return 4.0;
      case CheckboxSize.medium:
        return 6.0;
      case CheckboxSize.large:
        return 8.0;
    }
  }

  double _getIconSize() {
    switch (size) {
      case CheckboxSize.small:
        return 12.0;
      case CheckboxSize.medium:
        return 16.0;
      case CheckboxSize.large:
        return 20.0;
    }
  }

  double _getSpacing() {
    return size == CheckboxSize.small ? 8.0 : 12.0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final textTheme = theme.textTheme;

    // Neutral colors from theme
    final borderColor = theme.colorScheme.outline;
    final borderLightColor = theme.colorScheme.outlineVariant;
    final disabledColor = theme.disabledColor;

    final checkboxSize = _getSize();
    final borderRadius = _getBorderRadius();
    final iconSize = _getIconSize();
    final spacing = _getSpacing();

    return InkWell(
      onTap: enabled && onChanged != null ? () => onChanged!(!value) : null,
      focusNode: focusNode,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Checkbox
          Container(
            width: checkboxSize,
            height: checkboxSize,
            decoration: BoxDecoration(
              color: value
                  ? (enabled ? primaryColor : disabledColor)
                  : Colors.transparent,
              border: Border.all(
                color: value
                    ? (enabled ? primaryColor : disabledColor)
                    : (enabled ? borderColor : borderLightColor),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: value
                ? Icon(Icons.check, size: iconSize, color: Colors.white)
                : null,
          ),

          // Label
          if (label != null) ...[
            SizedBox(width: spacing),
            Flexible(
              child: Text(
                label!,
                style: (size == CheckboxSize.small
                        ? textTheme.bodySmall
                        : textTheme.bodyMedium)
                    ?.copyWith(
                  color: enabled
                      ? theme.colorScheme.onSurface
                      : theme.disabledColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// A form field wrapper for FormCheckbox with validation support.
///
/// Example:
/// ```dart
/// FormCheckboxFormField(
///   label: 'I agree to the terms',
///   validator: (value) => value ? null : 'You must agree to continue',
///   onSaved: (value) => print('Saved: $value'),
/// )
/// ```
class FormCheckboxFormField extends FormField<bool> {
  FormCheckboxFormField({
    super.key,
    String? label,
    CheckboxSize size = CheckboxSize.medium,
    bool super.initialValue = false,
    super.validator,
    super.onSaved,
    ValueChanged<bool>? onChanged,
    super.enabled,
    super.autovalidateMode,
  }) : super(
          builder: (FormFieldState<bool> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                FormCheckbox(
                  value: state.value ?? false,
                  onChanged: enabled
                      ? (value) {
                          state.didChange(value);
                          onChanged?.call(value);
                        }
                      : null,
                  label: label,
                  size: size,
                  enabled: enabled,
                ),

                // Error text
                if (state.hasError) ...[
                  const SizedBox(height: 8),
                  Text(
                    state.errorText!,
                    style: TextStyle(
                      color: Theme.of(state.context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            );
          },
        );
}
