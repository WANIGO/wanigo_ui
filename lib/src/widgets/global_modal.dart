import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/src/texts/global_text.dart';
import 'package:wanigo_ui/src/widgets/global_button.dart';

/// A global modal component for displaying notifications, confirmations, or alerts.
class GlobalModal extends StatelessWidget {
  final String? title;
  final String? message;
  final String? imagePath;
  final String primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback onPrimaryButtonPressed;
  final VoidCallback? onSecondaryButtonPressed;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double? imageSize;
  final double? gap;

  const GlobalModal({
    super.key,
    this.title,
    this.message,
    this.imagePath,
    required this.primaryButtonText,
    this.secondaryButtonText,
    required this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.imageSize,
    this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Container(
        width: width ?? 353.w,
        constraints: BoxConstraints(
          minHeight: 100.h,
          maxHeight: height ?? 400.h,
        ),
        padding: padding ?? EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imagePath != null) ...[
              Image.asset(
                imagePath!,
                width: imageSize ?? 100.r,
                height: imageSize ?? 100.r,
                fit: BoxFit.contain,
              ),
              SizedBox(height: gap ?? 9.28.h),
            ],
            if (title != null) ...[
              GlobalText(
                text: title!,
                variant: TextVariant.h4,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: gap ?? 9.28.h),
            ],
            if (message != null) ...[
              GlobalText(
                text: message!,
                variant: TextVariant.mediumMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: gap ?? 9.28.h * 2),
            ],
            GlobalButton(
              text: primaryButtonText,
              onPressed: onPrimaryButtonPressed,
              isFullWidth: true,
              variant: ButtonVariant.medium, // Tambahkan varian
            ),
            if (secondaryButtonText != null) ...[
              SizedBox(height: gap ?? 9.28.h),
              GlobalButton(
                text: secondaryButtonText!,
                onPressed: onSecondaryButtonPressed ??
                    () => Navigator.of(context).pop(),
                isFullWidth: true,
                backgroundColor: Colors.white,
                textColor: Colors.blue,
                borderRadius: BorderRadius.circular(10.r),
                variant: ButtonVariant.small, // Tambahkan varian
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Helper method to show the modal as a dialog
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    String? message,
    String? imagePath,
    required String primaryButtonText,
    String? secondaryButtonText,
    required VoidCallback onPrimaryButtonPressed,
    VoidCallback? onSecondaryButtonPressed,
    double? width,
    double? height,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    Color? backgroundColor,
    double? imageSize,
    double? gap,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => GlobalModal(
        title: title,
        message: message,
        imagePath: imagePath,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryButtonPressed: onPrimaryButtonPressed,
        onSecondaryButtonPressed: onSecondaryButtonPressed,
        width: width,
        height: height,
        padding: padding,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        imageSize: imageSize,
        gap: gap,
      ),
    );
  }
}
