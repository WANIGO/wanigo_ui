import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/src/texts/global_text.dart';

/// A global text field component that provides consistent styling across the app.
class GlobalTextField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // Get theme colors
    final Color defaultBorderColor = borderColor ?? Colors.grey.shade300;
    final Color defaultFillColor = fillColor ?? Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          GlobalText(
            text: label!,
            variant: TextVariant.smallSemiBold,
            color: Colors.black87,
          ),
          SizedBox(height: 8.h),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          enabled: enabled,
          onChanged: onChanged,
          validator: validator,
          inputFormatters: inputFormatters,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          textInputAction: textInputAction,
          maxLength: maxLength,
          maxLines: obscureText ? 1 : maxLines,
          autofocus: autofocus,
          readOnly: readOnly,
          onTap: onTap,
          textCapitalization: textCapitalization,
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontSize: 16.sp,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 16.sp,
              color: Colors.grey,
            ),
            helperText: helperText,
            errorText: errorText,
            filled: true,
            fillColor: enabled ? defaultFillColor : Colors.grey.shade100,
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 12.w,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: defaultBorderColor,
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
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: Colors.red.shade700,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: Colors.red.shade700,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
