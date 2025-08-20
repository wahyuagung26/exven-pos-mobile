import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String? label;
  final String? hintText;
  final T? value;
  final List<T> items;
  final String Function(T) displayText;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool enabled;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final bool isDense;
  final double? itemHeight;

  const CustomDropdown({
    super.key,
    this.label,
    this.hintText,
    this.value,
    required this.items,
    required this.displayText,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.prefixIcon,
    this.contentPadding,
    this.isDense = false,
    this.itemHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return DropdownButtonFormField<T>(
      value: value,
      onChanged: enabled ? onChanged : null,
      validator: validator,
      isDense: isDense,
      itemHeight: itemHeight,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding ?? const EdgeInsets.all(16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 2.0,
          ),
        ),
      ),
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(displayText(item)),
        );
      }).toList(),
    );
  }
}

class SearchableDropdown<T> extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? searchHint;
  final T? value;
  final List<T> items;
  final String Function(T) displayText;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool enabled;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final int maxItemsToShow;

  const SearchableDropdown({
    super.key,
    this.label,
    this.hintText,
    this.searchHint,
    this.value,
    required this.items,
    required this.displayText,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.prefixIcon,
    this.contentPadding,
    this.maxItemsToShow = 5,
  });

  @override
  State<SearchableDropdown<T>> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  late TextEditingController _searchController;
  late FocusNode _focusNode;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: widget.value != null ? widget.displayText(widget.value as T) : '',
    );
    _focusNode = FocusNode();
    _filteredItems = widget.items;
    
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _hideOverlay();
    super.dispose();
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: widget.maxItemsToShow * 56.0,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  final item = _filteredItems[index];
                  return ListTile(
                    dense: true,
                    title: Text(widget.displayText(item)),
                    onTap: () {
                      _selectItem(item);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectItem(T item) {
    setState(() {
      _searchController.text = widget.displayText(item);
    });
    widget.onChanged?.call(item);
    _focusNode.unfocus();
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items
            .where((item) =>
                widget.displayText(item).toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
    _overlayEntry?.markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        controller: _searchController,
        focusNode: _focusNode,
        validator: (value) {
          if (widget.validator != null) {
            final selectedItem = widget.items.firstWhere(
              (item) => widget.displayText(item) == value,
              orElse: () => throw StateError('Item not found'),
            );
            return widget.validator!(selectedItem);
          }
          return null;
        },
        enabled: widget.enabled,
        onChanged: _filterItems,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: const Icon(Icons.arrow_drop_down),
          contentPadding: widget.contentPadding ?? const EdgeInsets.all(16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: theme.colorScheme.outline.withOpacity(0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: theme.colorScheme.error,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: theme.colorScheme.error,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

class MultiSelectDropdown<T> extends StatefulWidget {
  final String? label;
  final String? hintText;
  final List<T> selectedValues;
  final List<T> items;
  final String Function(T) displayText;
  final void Function(List<T>)? onChanged;
  final String? Function(List<T>?)? validator;
  final bool enabled;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final int maxItemsToShow;

  const MultiSelectDropdown({
    super.key,
    this.label,
    this.hintText,
    required this.selectedValues,
    required this.items,
    required this.displayText,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.prefixIcon,
    this.contentPadding,
    this.maxItemsToShow = 5,
  });

  @override
  State<MultiSelectDropdown<T>> createState() => _MultiSelectDropdownState<T>();
}

class _MultiSelectDropdownState<T> extends State<MultiSelectDropdown<T>> {
  bool _isExpanded = false;

  String get _displayText {
    if (widget.selectedValues.isEmpty) {
      return widget.hintText ?? 'Select items';
    }
    
    if (widget.selectedValues.length == 1) {
      return widget.displayText(widget.selectedValues.first);
    }
    
    return '${widget.selectedValues.length} items selected';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        InkWell(
          onTap: widget.enabled ? () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          } : null,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: widget.label,
              prefixIcon: widget.prefixIcon,
              suffixIcon: Icon(
                _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              ),
              contentPadding: widget.contentPadding ?? const EdgeInsets.all(16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2.0,
                ),
              ),
            ),
            child: Text(
              _displayText,
              style: widget.selectedValues.isEmpty
                  ? theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    )
                  : null,
            ),
          ),
        ),
        if (_isExpanded)
          Container(
            margin: const EdgeInsets.only(top: 4.0),
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.outline),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: widget.maxItemsToShow * 56.0,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  final isSelected = widget.selectedValues.contains(item);
                  
                  return CheckboxListTile(
                    dense: true,
                    value: isSelected,
                    title: Text(widget.displayText(item)),
                    onChanged: widget.enabled ? (bool? selected) {
                      final newSelection = List<T>.from(widget.selectedValues);
                      
                      if (selected == true) {
                        newSelection.add(item);
                      } else {
                        newSelection.remove(item);
                      }
                      
                      widget.onChanged?.call(newSelection);
                    } : null,
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}