import 'package:flutter/material.dart';

/// A custom dropdown component for selecting from a list of options.
///
/// This component automatically adapts to the app's theme colors.
/// It uses Theme.of(context).primaryColor for focus and selection states.
///
/// Features:
/// - Dropdown menu with rounded container
/// - Selected option highlight
/// - Multiple states: empty, selected, error, disabled
/// - Optional label and helper text
/// - Form validation support
/// - Theme-aware styling
///
/// Example:
/// ```dart
/// CustomDropdown<String>(
///   label: 'Country',
///   placeholder: 'Select your country',
///   items: ['USA', 'UK', 'Canada'],
///   itemBuilder: (item) => item,
///   onChanged: (value) => print(value),
/// )
/// ```
class CustomDropdown<T> extends StatefulWidget {
  /// The label text displayed above the field
  final String? label;

  /// Placeholder text shown when no item is selected
  final String? placeholder;

  /// Helper text displayed below the field
  final String? helperText;

  /// Error text displayed when validation fails
  final String? errorText;

  /// List of items to display in dropdown
  final List<T> items;

  /// Function to build display text for each item
  final String Function(T) itemBuilder;

  /// Initial selected value
  final T? initialValue;

  /// Called when an item is selected
  final ValueChanged<T?>? onChanged;

  /// Validation function
  final String? Function(T?)? validator;

  /// Focus node for managing focus
  final FocusNode? focusNode;

  /// Whether the field is enabled
  final bool enabled;

  /// Icon to display on the right side
  final IconData? suffixIcon;

  /// Whether to show search functionality (for large lists)
  final bool enableSearch;

  const CustomDropdown({
    super.key,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    required this.items,
    required this.itemBuilder,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.enabled = true,
    this.suffixIcon,
    this.enableSearch = false,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  late FocusNode _focusNode;
  T? _selectedValue;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
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

  Color _getBorderColor(ThemeData theme) {
    if (!widget.enabled) {
      return theme.colorScheme.outlineVariant;
    }
    if (widget.errorText != null) {
      return theme.colorScheme.error;
    }
    if (_isFocused) {
      return theme.primaryColor;
    }
    return theme.colorScheme.outline;
  }

  double _getBorderWidth() {
    if (widget.errorText != null) {
      return 2.0;
    }
    return _isFocused ? 2.0 : 1.5;
  }

  Future<void> _showDropdownMenu(BuildContext context) async {
    if (!widget.enabled || widget.items.isEmpty) return;

    final theme = Theme.of(context);
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final T? selected = await showMenu<T>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height + 8,
        offset.dx + size.width,
        offset.dy + size.height + 300,
      ),
      items: widget.items.map((item) {
        final isSelected = item == _selectedValue;
        return PopupMenuItem<T>(
          value: item,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.primaryColor.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.itemBuilder(item),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? theme.primaryColor
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
        );
      }).toList(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: theme.colorScheme.surface,
      elevation: 8,
    );

    if (selected != null && selected != _selectedValue) {
      setState(() {
        _selectedValue = selected;
      });
      widget.onChanged?.call(selected);
    }
  }

  String _getDisplayText() {
    if (_selectedValue != null) {
      return widget.itemBuilder(_selectedValue as T);
    }
    return widget.placeholder ?? 'Select an option';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final hasError = widget.errorText != null;
    final hasValue = _selectedValue != null;

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

        // Dropdown Field
        InkWell(
          onTap: widget.enabled ? () => _showDropdownMenu(context) : null,
          onFocusChange: (focused) {
            setState(() {
              _isFocused = focused;
            });
          },
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
                color: _getBorderColor(theme),
                width: _getBorderWidth(),
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
                  widget.suffixIcon ?? Icons.keyboard_arrow_down,
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
            hasError ? widget.errorText! : widget.helperText!,
            style: hasError ? errorStyle : helperStyle,
          ),
        ],
      ],
    );
  }
}
