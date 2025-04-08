import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/src/texts/global_text.dart';


/// A global button component that provides consistent button styling
/// based on the design system.
class GlobalButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final TextVariant textVariant;
  final bool disabled;
  final Widget? prefix;
  final Widget? suffix;
  final double? gap;

  const GlobalButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.textVariant = TextVariant.mediumSemiBold,
    this.disabled = false,
    this.prefix,
    this.suffix,
    this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 353.w,
      height: height ?? 48.h,
      child: ElevatedButton(
        onPressed: disabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF0A5AEB),
          disabledBackgroundColor: backgroundColor != null
              ? backgroundColor!.withOpacity(0.5)
              : const Color(0xFF0A5AEB).withOpacity(0.5),
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          shape: RoundedRectangleBorder(
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
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefix != null) prefix!,
                  if (prefix != null) SizedBox(width: gap ?? 8.w),
                  Flexible(
                    child: GlobalText(
                      text: text,
                      variant: textVariant,
                      color: textColor ?? Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (suffix != null) SizedBox(width: gap ?? 8.w),
                  if (suffix != null) suffix!,
                ],
              ),
      ),
    );
  }
}
