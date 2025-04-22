import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/src/core/global_style/global_color.dart';
import 'package:wanigo_ui/src/texts/global_text.dart';

/// A global dropdown component that provides consistent styling across the app.
class GlobalDropdown<T> extends StatefulWidget {
  final String? label;
  final String hint;
  final T? value;
  final List<DropdownItem<T>> items;
  final Function(T?)? onChanged;
  final bool enabled;
  final String? errorText;
  final String? helperText;
  final Color? borderColor;
  final Color? fillColor;

  const GlobalDropdown({
    super.key,
    this.label,
    required this.hint,
    this.value,
    required this.items,
    this.onChanged,
    this.enabled = true,
    this.errorText,
    this.helperText,
    this.borderColor,
    this.fillColor,
  });

  @override
  State<GlobalDropdown<T>> createState() => _GlobalDropdownState<T>();
}

class _GlobalDropdownState<T> extends State<GlobalDropdown<T>> {
  final GlobalKey _dropdownKey = GlobalKey();
  bool _isOpen = false;
  late OverlayEntry _overlayEntry;
  late T? _selectedValue;
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isOpen) {
        _removeOverlay();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;
    
    setState(() {
      _isOpen = !_isOpen;
    });
    
    if (_isOpen) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry);
      _focusNode.requestFocus();
    } else {
      _removeOverlay();
    }
  }

  void _removeOverlay() {
    if (_isOpen) {
      _overlayEntry.remove();
      setState(() {
        _isOpen = false;
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 4),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFFDFE1E7)), // Greyscale-100
                color: Colors.white,
              ),
              constraints: BoxConstraints(
                maxHeight: 200.h,
              ),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: widget.items.map((item) {
                  bool isSelected = _selectedValue == item.value;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedValue = item.value;
                      });
                      widget.onChanged?.call(item.value);
                      _removeOverlay();
                    },
                    child: Container(
                      height: 44.h,
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: isSelected ? const Color(0xFFF6F8FA) : Colors.white, // Greyscale-25 if selected
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GlobalText(
                              text: item.text,
                              variant: TextVariant.mediumRegular,
                              color: isSelected ? AppColors.blue500 : Colors.black,
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check,
                              color: AppColors.blue500,
                              size: 20.w,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get theme colors
    final Color defaultBorderColor = widget.borderColor ?? const Color(0xFFDFE1E7); // Greyscale-100
    final Color defaultFillColor = widget.fillColor ?? Colors.white; // Greyscale-0
    final Color focusedBorderColor = const Color(0xFFA688F8); // Purple for active state
    final Color errorColor = AppColors.red500;

    // Find the selected item for display
    String displayText = widget.hint;
    if (_selectedValue != null) {
      for (var item in widget.items) {
        if (item.value == _selectedValue) {
          displayText = item.text;
          break;
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          GlobalText(
            text: widget.label!,
            variant: TextVariant.smallRegular,
            color: Colors.black87,
          ),
          SizedBox(height: 8.h),
        ],
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _toggleDropdown,
            child: Focus(
              focusNode: _focusNode,
              child: Container(
                key: _dropdownKey,
                height: 48.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: widget.errorText != null
                        ? errorColor
                        : _isOpen
                            ? focusedBorderColor
                            : defaultBorderColor,
                    width: 1,
                  ),
                  color: widget.enabled ? defaultFillColor : const Color(0xFFF6F8FA), // Greyscale-25 if disabled
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GlobalText(
                        text: displayText,
                        variant: TextVariant.mediumRegular,
                        color: _selectedValue != null 
                            ? Colors.black 
                            : const Color(0xFF6B6F70), // Grey-300 for placeholder
                      ),
                    ),
                    Icon(
                      _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: const Color(0xFF6B6F70), // Grey-300
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          SizedBox(height: 4.h),
          GlobalText(
            text: widget.errorText!,
            variant: TextVariant.smallRegular,
            color: errorColor,
          ),
        ] else if (widget.helperText != null) ...[
          SizedBox(height: 4.h),
          GlobalText(
            text: widget.helperText!,
            variant: TextVariant.smallRegular,
            color: const Color(0xFF6B6F70), // Grey-300
          ),
        ],
      ],
    );
  }
}

/// A class to represent dropdown items
class DropdownItem<T> {
  final String text;
  final T value;

  DropdownItem({required this.text, required this.value});
}