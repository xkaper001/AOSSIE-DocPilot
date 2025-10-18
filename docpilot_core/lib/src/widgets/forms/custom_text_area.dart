import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A custom text area component for multi-line text input.
///
/// This component automatically adapts to the app's theme colors.
/// It uses Theme.of(context).colorScheme.primary for focus states and
/// Theme.of(context).colorScheme.error for error states.
///
/// Features:
/// - Multi-line input with expandable height
/// - Multiple states: empty, typing, filled, error, disabled
/// - Optional label and helper text
/// - Form validation support with FormField integration
/// - Theme-aware styling (Material 3 compliant)
///
/// Example:
/// ```dart
/// CustomTextArea(
///   label: 'Description',
///   placeholder: 'Enter your description',
///   minLines: 3,
///   maxLines: 6,
///   validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
/// )
/// ```
class CustomTextArea extends StatefulWidget {
  /// The label text displayed above the field
  final String? label;

  /// Placeholder text shown when field is empty
  final String? placeholder;

  /// Helper text displayed below the field
  final String? helperText;

  /// Error text displayed when validation fails
  final String? errorText;

  /// Initial value of the text area
  final String? initialValue;

  /// Controller for the text area
  final TextEditingController? controller;

  /// Validation function
  final String? Function(String?)? validator;

  /// Called when the text changes
  final ValueChanged<String>? onChanged;

  /// Called when editing is complete
  final VoidCallback? onEditingComplete;

  /// Called when the field is submitted
  final ValueChanged<String>? onSubmitted;

  /// Focus node for managing focus
  final FocusNode? focusNode;

  /// Whether the field is enabled
  final bool enabled;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Text input action
  final TextInputAction? textInputAction;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Maximum number of characters
  final int? maxLength;

  /// Minimum number of lines
  final int minLines;

  /// Maximum number of lines (null for unlimited)
  final int? maxLines;

  /// Auto-focus on load
  final bool autofocus;

  /// Text capitalization
  final TextCapitalization textCapitalization;

  const CustomTextArea({
    super.key,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.initialValue,
    this.controller,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.focusNode,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.maxLength,
    this.minLines = 3,
    this.maxLines,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  State<CustomTextArea> createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late bool _createdController;
  late bool _createdFocusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _createdController = widget.controller == null;
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _createdFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();

    // Only add listener if we created the FocusNode
    if (_createdFocusNode) {
      _focusNode.addListener(_handleFocusChange);
    }
  }

  @override
  void dispose() {
    // Always remove listener if we added it
    if (_createdFocusNode) {
      _focusNode.removeListener(_handleFocusChange);
    }
    // Only dispose if we created them
    if (_createdController) {
      _controller.dispose();
    }
    if (_createdFocusNode) {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

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

    return FormField<String>(
      initialValue: widget.initialValue ?? _controller.text,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.disabled,
      builder: (field) {
        final effectiveErrorText = widget.errorText ?? field.errorText;
        final hasError = effectiveErrorText != null;

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

            // Text Area
            Container(
              constraints: BoxConstraints(
                minHeight: widget.minLines * 20.0 +
                    24, // line height * lines + padding
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getBorderColor(theme, hasError: hasError),
                  width: _getBorderWidth(hasError: hasError),
                ),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: widget.enabled,
                keyboardType: widget.keyboardType ?? TextInputType.multiline,
                textInputAction: widget.textInputAction,
                inputFormatters: widget.inputFormatters,
                maxLength: widget.maxLength,
                minLines: widget.minLines,
                maxLines: widget.maxLines,
                autofocus: widget.autofocus,
                textCapitalization: widget.textCapitalization,
                onChanged: (value) {
                  field.didChange(value);
                  widget.onChanged?.call(value);
                },
                onEditingComplete: widget.onEditingComplete,
                onSubmitted: widget.onSubmitted,
                style: widget.enabled ? inputStyle : disabledStyle,
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  hintStyle: placeholderStyle,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  counterText: '', // Hide character counter
                  isDense: true,
                ),
              ),
            ),

            // Helper Text or Error Text
            if (widget.helperText != null || hasError) ...[
              const SizedBox(height: 8),
              Text(
                hasError ? effectiveErrorText : (widget.helperText ?? ''),
                style: hasError ? errorStyle : helperStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        );
      },
    );
  }
}
