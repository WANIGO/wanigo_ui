import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/src/texts/global_text.dart';

/// A global button component that provides consistent button styling
/// based on the design system.
class GlobalButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonShape shape;
  final bool isLoading;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final TextVariant textVariant;
  final bool disabled;
  final Widget? prefix;
  final Widget? suffix;
  final double? gap;
  final bool showChevron;
  final Color? iconColor;

  const GlobalButton({
    super.key,
    this.text,
    required this.variant,
    this.shape = ButtonShape.rectangle,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.textVariant = TextVariant.mediumSemiBold,
    this.disabled = false,
    this.prefix,
    this.suffix,
    this.gap,
    this.showChevron = false,
    this.iconColor,
  }) : assert(shape == ButtonShape.circle ? text == null : true,
           'Text should be null for circle buttons');

  factory GlobalButton.withChevron({
    required String text,
    required ButtonVariant variant,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = true,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    TextVariant textVariant = TextVariant.mediumSemiBold,
    bool disabled = false,
  }) {
    return GlobalButton(
      text: text,
      variant: variant,
      onPressed: onPressed,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderRadius: borderRadius,
      padding: padding,
      textVariant: textVariant,
      disabled: disabled,
      showChevron: true,
      iconColor: iconColor,
    );
  }

  factory GlobalButton.circle({
    required ButtonVariant variant,
    VoidCallback? onPressed,
    bool isLoading = false,
    Color? backgroundColor,
    Color? iconColor, 
    bool disabled = false,
    bool showChevron = true,
  }) {
    return GlobalButton(
      variant: variant,
      shape: ButtonShape.circle,
      onPressed: onPressed,
      isLoading: isLoading,
      isFullWidth: false,
      backgroundColor: backgroundColor,
      disabled: disabled,
      showChevron: showChevron,
      iconColor: iconColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine size based on variant and shape
    final double? width;
    final double? height;
    final double iconSize;

    switch (variant) {
      case ButtonVariant.small:
        width = shape == ButtonShape.circle 
            ? 32.w 
            : (isFullWidth ? 200.w : null);
        height = shape == ButtonShape.circle ? 32.h : 36.h;
        iconSize = 14.w;
        break;
      case ButtonVariant.medium:
        width = shape == ButtonShape.circle 
            ? 40.w 
            : (isFullWidth ? 300.w : null);
        height = shape == ButtonShape.circle ? 40.h : 48.h;
        iconSize = 16.w;
        break;
      case ButtonVariant.large:
        width = shape == ButtonShape.circle 
            ? 48.w 
            : (isFullWidth ? 400.w : null);
        height = shape == ButtonShape.circle ? 48.h : 56.h;
        iconSize = 18.w;
        break;
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: disabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF0A5AEB),
          disabledBackgroundColor: backgroundColor != null
              ? backgroundColor!.withOpacity(0.5)
              : const Color(0xFF0A5AEB).withOpacity(0.5),
          padding: shape == ButtonShape.circle 
              ? EdgeInsets.zero 
              : (padding ?? EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w)),
          shape: shape == ButtonShape.circle
              ? const CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(10.r),
                ),
          elevation: 0,
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : _buildButtonContent(iconSize),
      ),
    );
  }

  Widget _buildButtonContent(double iconSize) {
    // For circle buttons, just show the chevron icon
    if (shape == ButtonShape.circle) {
      return Icon(
        Icons.chevron_right,
        color: iconColor ?? Colors.white,
        size: iconSize,
      );
    }

    // For rectangular buttons
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (prefix != null) prefix!,
        if (prefix != null) SizedBox(width: gap ?? 8.w),
        if (text != null)
          Flexible(
            child: GlobalText(
              text: text!,
              variant: textVariant,
              color: textColor ?? Colors.white,
              textAlign: TextAlign.center,
            ),
          ),
        if (showChevron) SizedBox(width: gap ?? 8.w),
        if (showChevron)
          Icon(
            Icons.chevron_right,
            color: iconColor ?? Colors.white,
            size: iconSize,
          ),
        if (suffix != null && !showChevron) SizedBox(width: gap ?? 8.w),
        if (suffix != null && !showChevron) suffix!,
      ],
    );
  }
}

/// Enum for button size variants
enum ButtonVariant {
  small,
  medium,
  large,
}

/// Enum for button shape variants
enum ButtonShape {
  rectangle,
  circle,
}