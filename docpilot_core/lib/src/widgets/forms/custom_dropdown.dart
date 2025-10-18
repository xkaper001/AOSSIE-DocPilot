import 'package:flutter/material.dart';

/// A custom dropdown component for selecting from a list of options.
///
/// This component automatically adapts to the app's theme colors.
/// It uses Theme.of(context).colorScheme.primary for focus and selection states.
///
/// Features:
/// - Dropdown menu with rounded container
/// - Selected option highlight
/// - Multiple states: empty, selected, error, disabled
/// - Optional label and helper text
/// - Form validation support
/// - Optional search field for filtering items (when enableSearch is true)
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
///   enableSearch: true,
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
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _dropdownOverlayEntry;

  void _showDropdownOverlay(FormFieldState<T> field) {
    if (!widget.enabled || widget.items.isEmpty) return;
    final theme = Theme.of(context);
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;

    TextEditingController searchController = TextEditingController();
    String query = '';

    _dropdownOverlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 8),
            child: Material(
              color: theme.colorScheme.surface,
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              child: StatefulBuilder(
                builder: (context, setState) {
                  final filteredItems = widget.enableSearch && query.isNotEmpty
                      ? widget.items.where((item) {
                          final itemText =
                              widget.itemBuilder(item).toLowerCase();
                          return itemText.contains(query.toLowerCase());
                        }).toList()
                      : widget.items;
                  return Container(
                    constraints: BoxConstraints(maxHeight: 400),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.enableSearch)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                prefixIcon: const Icon(Icons.search, size: 20),
                                suffixIcon: query.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear, size: 20),
                                        onPressed: () {
                                          searchController.clear();
                                          setState(() {
                                            query = '';
                                          });
                                        },
                                      )
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.outline,
                                    width: 1,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                isDense: true,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  query = value;
                                });
                              },
                            ),
                          ),
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredItems.length,
                            itemBuilder: (context, index) {
                              final item = filteredItems[index];
                              final isSelected = item == _selectedValue;
                              return InkWell(
                                onTap: () {
                                  _removeDropdownOverlay();
                                  if (item != _selectedValue) {
                                    setState(() {
                                      _selectedValue = item;
                                    });
                                    field.didChange(item);
                                    widget.onChanged?.call(item);
                                  }
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? theme.colorScheme.primary
                                            .withOpacity(0.1)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    widget.itemBuilder(item),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: isSelected
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(_dropdownOverlayEntry!);
  }

  void _removeDropdownOverlay() {
    _dropdownOverlayEntry?.remove();
    _dropdownOverlayEntry = null;
  }

  @override
  void didUpdateWidget(covariant CustomDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue ||
        widget.items != oldWidget.items) {
      setState(() {
        _selectedValue = widget.initialValue;
      });
    }

    if (widget.placeholder != oldWidget.placeholder ||
        widget.initialValue != oldWidget.initialValue) {
      _searchController.text = '';
    }

    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_handleFocusChange);
      if (_createdFocusNode) {
        _focusNode.dispose();
      }
      _createdFocusNode = widget.focusNode == null;
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_handleFocusChange);
    }
  }

  late FocusNode _focusNode;
  late bool _createdFocusNode;
  T? _selectedValue;
  bool _isFocused = false;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    _createdFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();
    _searchController = TextEditingController();

    // Always listen for focus changes
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    // Always remove listener
    _focusNode.removeListener(_handleFocusChange);
    // Only dispose if we created the FocusNode
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _searchController.dispose();
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

    return FormField<T>(
      initialValue: _selectedValue,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.disabled,
      builder: (field) {
        final effectiveErrorText = widget.errorText ?? field.errorText;
        final hasError = effectiveErrorText != null;
        final hasValue = _selectedValue != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.label != null) ...[
              Text(
                widget.label!,
                style: labelStyle,
              ),
              const SizedBox(height: 8),
            ],
            CompositedTransformTarget(
              link: _layerLink,
              child: InkWell(
                onTap:
                    widget.enabled ? () => _showDropdownOverlay(field) : null,
                onFocusChange: null,
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
            ),
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
