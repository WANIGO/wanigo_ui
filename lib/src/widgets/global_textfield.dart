import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/src/core/global_style/global_color.dart';
import 'package:wanigo_ui/src/texts/global_text.dart';

/// A global text field component that provides consistent styling across the app.
class GlobalTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? maxLines;
  final bool autofocus;
  final bool readOnly;
  final VoidCallback? onTap;
  final Color? borderColor;
  final Color? fillColor;
  final TextCapitalization textCapitalization;

  const GlobalTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.focusNode,
    this.onEditingComplete,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.maxLines = 1,
    this.autofocus = false,
    this.readOnly = false,
    this.onTap,
    this.borderColor,
    this.fillColor,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  late bool _obscureText;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
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

  @override
  Widget build(BuildContext context) {
    // Get theme colors
    final Color defaultBorderColor = widget.borderColor ?? const Color(0xFFDFE1E7); // Greyscale-100
    final Color defaultFillColor = widget.fillColor ?? Colors.white; // Greyscale-0
    final Color focusedBorderColor = const Color(0xFFA688F8); // Purple for active state
    final Color errorColor = AppColors.red500;

    // Get current border color based on state
    final Color currentBorderColor = widget.errorText != null
        ? errorColor
        : _isFocused
            ? focusedBorderColor
            : defaultBorderColor;

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
        SizedBox(
          height: 48.h, // Fixed height as per design
          child: TextFormField(
            controller: widget.controller,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            enabled: widget.enabled,
            onChanged: widget.onChanged,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            focusNode: _focusNode,
            onEditingComplete: widget.onEditingComplete,
            textInputAction: widget.textInputAction,
            maxLength: widget.maxLength,
            maxLines: _obscureText ? 1 : widget.maxLines,
            autofocus: widget.autofocus,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            textCapitalization: widget.textCapitalization,
            style: const TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 16, // Body Medium Regular
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 1.6, // Line height 160%
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(
                fontFamily: 'NunitoSans',
                fontSize: 16, // Body Medium Regular
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B6F70), // Grey-300
                height: 1.6, // Line height 160%
              ),
              helperText: widget.helperText,
              helperStyle: TextStyle(
                fontFamily: 'NunitoSans',
                fontSize: 12.sp, // Body Small Regular
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6B6F70), // Grey-300
              ),
              errorText: widget.errorText,
              errorStyle: TextStyle(
                fontFamily: 'NunitoSans',
                fontSize: 12.sp, // Body Small Regular
                fontWeight: FontWeight.w400,
                color: errorColor,
              ),
              filled: true,
              fillColor: widget.enabled ? defaultFillColor : const Color(0xFFF6F8FA), // Greyscale-25 for disabled
              contentPadding: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 12.w,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFF6B6F70), // Grey-300
                        size: 20.w,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : widget.suffixIcon,
              counterText: "", // Hide counter
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: currentBorderColor,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: defaultBorderColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: focusedBorderColor,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: errorColor,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: errorColor,
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: const Color(0xFFDFE1E7).withAlpha(128), // Greyscale-100 with alpha 0.5
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        if (widget.helperText != null && widget.errorText == null) ...[
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