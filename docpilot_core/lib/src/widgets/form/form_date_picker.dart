import 'package:flutter/material.dart';

/// A custom date picker component specifically designed for date of birth selection.
///
/// This component automatically adapts to the app's theme colors.
/// It uses Theme.of(context).primaryColor for focus and calendar theme.
///
/// Features:
/// - Calendar picker dialog
/// - Formatted date display
/// - Multiple states: empty, filled, error, disabled
/// - Optional label and helper text
/// - Form validation support
/// - Theme-aware styling
///
/// Example:
/// ```dart
/// FormDatePicker(
///   label: 'Date of Birth',
///   placeholder: 'Select your date of birth',
///   onDateSelected: (date) => print(date),
///   validator: (date) => date == null ? 'Date is required' : null,
/// )
/// ```
class FormDatePicker extends StatefulWidget {
  /// The label text displayed above the field
  final String? label;

  /// Placeholder text shown when no date is selected
  final String? placeholder;

  /// Helper text displayed below the field
  final String? helperText;

  /// Error text displayed when validation fails
  final String? errorText;

  /// Initial selected date
  final DateTime? initialDate;

  /// The earliest date the user can select
  final DateTime? firstDate;

  /// The latest date the user can select
  final DateTime? lastDate;

  /// Called when a date is selected
  final ValueChanged<DateTime>? onDateSelected;

  /// Validation function
  final String? Function(DateTime?)? validator;

  /// Focus node for managing focus
  final FocusNode? focusNode;

  /// Whether the field is enabled
  final bool enabled;

  /// Date format pattern (default: 'dd/MM/yyyy')
  final String dateFormat;

  /// Icon to display on the right side
  final IconData? suffixIcon;

  const FormDatePicker({
    super.key,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.validator,
    this.focusNode,
    this.enabled = true,
    this.dateFormat = 'dd/MM/yyyy',
    this.suffixIcon,
  });

  @override
  State<FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<FormDatePicker> {
  late FocusNode _focusNode;
  late bool _createdFocusNode;
  DateTime? _selectedDate;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _createdFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();

    // Only add listener if we created the FocusNode
    if (_createdFocusNode) {
      _focusNode.addListener(_handleFocusChange);
    }
  }

  @override
  void dispose() {
    // Only remove listener and dispose if we created the FocusNode
    if (_createdFocusNode) {
      _focusNode.removeListener(_handleFocusChange);
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  Color _getBorderColor(ThemeData theme, {required bool hasError}) {
    if (!widget.enabled) {
      return theme.colorScheme.outlineVariant;
    }
    if (hasError) {
      return theme.colorScheme.error;
    }
    if (_isFocused) {
      return theme.colorScheme.primary;
    }
    return theme.colorScheme.outline;
  }

  double _getBorderWidth({required bool hasError}) {
    if (hasError) {
      return 2.0;
    }
    return _isFocused ? 2.0 : 1.5;
  }

  String _formatDate(DateTime d, String pattern) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yyyy = d.year.toString().padLeft(4, '0');
    return pattern
        .replaceAll('dd', dd)
        .replaceAll('MM', mm)
        .replaceAll('yyyy', yyyy);
  }

  Future<void> _selectDate(BuildContext context) async {
    if (!widget.enabled) return;

    final theme = Theme.of(context);
    final DateTime firstDate = widget.firstDate ?? DateTime(1900);
    final DateTime lastDate = widget.lastDate ?? DateTime.now();
    final DateTime initialDate = _selectedDate ?? DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(firstDate)
          ? firstDate
          : (initialDate.isAfter(lastDate) ? lastDate : initialDate),
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: theme.primaryColor,
              onPrimary: Colors.white,
              onSurface: theme.colorScheme.onSurface,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: theme.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected?.call(picked);
    }
  }

  String _getDisplayText() {
    if (_selectedDate != null) {
      return _formatDate(_selectedDate!, widget.dateFormat);
    }
    return widget.placeholder ?? 'Select date';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final computedError =
        widget.errorText ?? widget.validator?.call(_selectedDate);
    final hasError = computedError != null;
    final hasValue = _selectedDate != null;

    // Text styles from theme
    final labelStyle = textTheme.labelLarge;
    final inputStyle = textTheme.bodyLarge;
    final placeholderStyle = textTheme.bodyLarge?.copyWith(
      color: theme.colorScheme.onSurface.withOpacity(0.5),
    );
    final helperStyle = textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurface.withOpacity(0.7),
    );
    final errorStyle = textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.error,
    );
    final disabledStyle = inputStyle?.copyWith(
      color: theme.disabledColor,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: labelStyle,
          ),
          const SizedBox(height: 8),
        ],

        // Date Picker Field
        InkWell(
          onTap: widget.enabled ? () => _selectDate(context) : null,
          onFocusChange: _createdFocusNode
              ? (focused) {
                  setState(() {
                    _isFocused = focused;
                  });
                }
              : null,
          focusNode: _focusNode,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _getBorderColor(theme, hasError: hasError),
                width: _getBorderWidth(hasError: hasError),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _getDisplayText(),
                    style: hasValue
                        ? (widget.enabled ? inputStyle : disabledStyle)
                        : placeholderStyle,
                  ),
                ),
                Icon(
                  widget.suffixIcon ?? Icons.calendar_today_outlined,
                  size: 20,
                  color: widget.enabled
                      ? theme.colorScheme.onSurface.withOpacity(0.7)
                      : theme.disabledColor,
                ),
              ],
            ),
          ),
        ),

        // Helper Text or Error Text
        if (widget.helperText != null || hasError) ...[
          const SizedBox(height: 8),
          Text(
            hasError ? computedError : (widget.helperText ?? ''),
            style: hasError ? errorStyle : helperStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
