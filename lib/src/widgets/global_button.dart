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
  final ButtonStyle style;
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
  final ButtonState buttonState;

  const GlobalButton({
    super.key,
    this.text,
    required this.variant,
    this.shape = ButtonShape.rectangle,
    this.style = ButtonStyle.primary,
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
    this.buttonState = ButtonState.default_,
  }) : assert(shape == ButtonShape.circle ? text == null : true,
           'Text should be null for circle buttons');

  factory GlobalButton.withChevron({
    required String text,
    required ButtonVariant variant,
    ButtonStyle style = ButtonStyle.primary,
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
    ButtonState buttonState = ButtonState.default_,
  }) {
    return GlobalButton(
      text: text,
      variant: variant,
      style: style,
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
      buttonState: buttonState,
    );
  }

  factory GlobalButton.circle({
    required ButtonVariant variant,
    ButtonStyle style = ButtonStyle.primary,
    VoidCallback? onPressed,
    bool isLoading = false,
    Color? backgroundColor,
    Color? iconColor, 
    bool disabled = false,
    bool showChevron = true,
    ButtonState buttonState = ButtonState.default_,
  }) {
    return GlobalButton(
      variant: variant,
      style: style,
      shape: ButtonShape.circle,
      onPressed: onPressed,
      isLoading: isLoading,
      isFullWidth: false,
      backgroundColor: backgroundColor,
      disabled: disabled,
      showChevron: showChevron,
      iconColor: iconColor,
      buttonState: buttonState,
    );
  }

  factory GlobalButton.tertiary({
    required String text,
    required ButtonVariant variant,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = true,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    TextVariant textVariant = TextVariant.mediumSemiBold,
    bool disabled = false,
    ButtonState buttonState = ButtonState.default_,
    Widget? prefix,
    Widget? suffix,
    double? gap,
    bool showChevron = false,
  }) {
    return GlobalButton(
      text: text,
      variant: variant,
      style: ButtonStyle.tertiary,
      onPressed: onPressed,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      borderRadius: borderRadius,
      padding: padding,
      textVariant: textVariant,
      disabled: disabled,
      buttonState: buttonState,
      prefix: prefix,
      suffix: suffix,
      gap: gap,
      showChevron: showChevron,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine size based on variant and shape
    final double? width;
    final double height;
    final double iconSize;
    final TextVariant effectiveTextVariant;

    switch (variant) {
      case ButtonVariant.xsmall:
        width = shape == ButtonShape.circle 
            ? 32.w 
            : (isFullWidth ? double.infinity : null);
        height = shape == ButtonShape.circle ? 32.h : 32.h;
        iconSize = 12.w;
        effectiveTextVariant = TextVariant.xSmallSemiBold;
        break;
      case ButtonVariant.small:
        width = shape == ButtonShape.circle 
            ? 40.w 
            : (isFullWidth ? double.infinity : null);
        height = shape == ButtonShape.circle ? 40.h : 40.h;
        iconSize = 14.w;
        effectiveTextVariant = TextVariant.smallSemiBold;
        break;
      case ButtonVariant.medium:
        width = shape == ButtonShape.circle 
            ? 48.w 
            : (isFullWidth ? double.infinity : null);
        height = shape == ButtonShape.circle ? 48.h : 48.h;
        iconSize = 16.w;
        effectiveTextVariant = TextVariant.mediumSemiBold;
        break;
      case ButtonVariant.large:
        width = shape == ButtonShape.circle 
            ? 52.w 
            : (isFullWidth ? double.infinity : null);
        height = shape == ButtonShape.circle ? 52.h : 52.h;
        iconSize = 18.w;
        effectiveTextVariant = TextVariant.mediumSemiBold;
        break;
    }

    // Determine style properties based on the button style
    final Color effectiveBackgroundColor = _getBackgroundColor();
    final Color effectiveTextColor = _getTextColor();
    final Color effectiveIconColor = iconColor ?? effectiveTextColor;
    
    // Get box shadow based on state
    final List<BoxShadow>? boxShadow = _getBoxShadow();

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: disabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          disabledBackgroundColor: _getDisabledBackgroundColor(),
          padding: shape == ButtonShape.circle 
              ? EdgeInsets.zero 
              : (padding ?? EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w)),
          shape: shape == ButtonShape.circle
              ? const CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(10.r),
                ),
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ).copyWith(
          shadowColor: const MaterialStatePropertyAll(Colors.transparent),
          elevation: const MaterialStatePropertyAll(0),
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.hovered)) {
              // Different hover colors based on button style
              if (style == ButtonStyle.tertiary) {
                return const Color(0xFFE8E9EC); // Lighter hover for tertiary
              }
              return const Color(0xFF052D76); // Blue-800 for hover state (primary)
            }
            return null; // Use default overlay color
          }),
          // Apply background color based on state
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return _getDisabledBackgroundColor();
              }
              if (states.contains(MaterialState.hovered)) {
                if (style == ButtonStyle.tertiary) {
                  return const Color(0xFFE8E9EC); // Lighter hover for tertiary
                }
                return const Color(0xFF052D76); // Blue-800 for hover (primary)
              }
              return effectiveBackgroundColor;
            },
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: boxShadow,
            borderRadius: shape == ButtonShape.circle 
                ? null 
                : (borderRadius ?? BorderRadius.circular(10.r)),
          ),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: effectiveTextColor,
                    strokeWidth: 3,
                  ),
                )
              : _buildButtonContent(iconSize, effectiveTextVariant, effectiveTextColor, effectiveIconColor),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    // Override with provided backgroundColor
    if (backgroundColor != null) return backgroundColor!;

    if (disabled) {
      return _getDisabledBackgroundColor();
    }
    
    // Get color based on style and state
    switch (style) {
      case ButtonStyle.primary:
        switch (buttonState) {
          case ButtonState.default_:
            return const Color(0xFF0A5AEB); // Blue-500
          case ButtonState.active:
            return const Color(0xFF0A5AEB); // Blue-500
          case ButtonState.hover:
            return const Color(0xFF052D76); // Blue-800
          case ButtonState.disabled:
            return const Color(0xFFADC8F8); // Blue-200
        }
      case ButtonStyle.secondary:
        return Colors.white; // White background for secondary
      case ButtonStyle.tertiary:
        return const Color(0xFFF6F8FA); // Grey background F6F8FA
    }
  }

  Color _getDisabledBackgroundColor() {
    switch (style) {
      case ButtonStyle.primary:
        return const Color(0xFFADC8F8); // Blue-200 for disabled primary
      case ButtonStyle.secondary:
        return Colors.white.withAlpha(179); // Semi-transparent white for disabled secondary (0.7 * 255 = 179)
      case ButtonStyle.tertiary:
        return const Color(0xFFF6F8FA).withAlpha(179); // Semi-transparent grey for disabled tertiary (0.7 * 255 = 179)
    }
  }

  Color _getTextColor() {
    // Override with provided textColor
    if (textColor != null) return textColor!;

    if (disabled) {
      switch (style) {
        case ButtonStyle.primary:
          return Colors.white.withAlpha(179); // 0.7 * 255 = 179
        case ButtonStyle.secondary:
          return const Color(0xFF6B6F70).withAlpha(179); // Grey-500 semi-transparent
        case ButtonStyle.tertiary:
          return const Color(0xFF6B6F70).withAlpha(179); // Grey-500 semi-transparent
      }
    }

    switch (style) {
      case ButtonStyle.primary:
        return Colors.white;
      case ButtonStyle.secondary:
        return const Color(0xFF0A5AEB); // Blue-500
      case ButtonStyle.tertiary:
        return const Color(0xFF6B6F70); // Grey-500
    }
  }

  List<BoxShadow>? _getBoxShadow() {
    if (buttonState == ButtonState.active) {
      // Focused/primary shadow
      return [
        BoxShadow(
          color: const Color(0xFFA688F8).withAlpha(255), // inset shadow
          spreadRadius: 1,
          blurRadius: 0,
          offset: const Offset(0, 0),
        ),
        BoxShadow(
          color: const Color(0xFF6B39F4).withAlpha(38), // 0.15 opacity
          spreadRadius: 3,
          blurRadius: 1,
          offset: const Offset(0, 0),
        ),
      ];
    } else if (buttonState == ButtonState.hover) {
      // Hover state shadow
      return [
        BoxShadow(
          color: const Color(0xFF0D0D12).withAlpha(15), // 0.06 opacity
          spreadRadius: 0,
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ];
    }
    
    return null; // No shadow for default and disabled states
  }

  Widget _buildButtonContent(double iconSize, TextVariant effectiveTextVariant, Color textColor, Color iconColor) {
    // For circle buttons, just show the chevron icon
    if (shape == ButtonShape.circle) {
      return Icon(
        Icons.chevron_right,
        color: iconColor,
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
              variant: effectiveTextVariant,
              color: textColor,
              textAlign: TextAlign.center,
            ),
          ),
        if (showChevron) SizedBox(width: gap ?? 8.w),
        if (showChevron)
          Icon(
            Icons.chevron_right,
            color: iconColor,
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
  xsmall,
  small,
  medium,
  large,
}

/// Enum for button shape variants
enum ButtonShape {
  rectangle,
  circle,
}

/// Enum for button states
enum ButtonState {
  default_,
  active,
  hover,
  disabled,
}

/// Enum for button style variants
enum ButtonStyle {
  primary,
  secondary,
  tertiary,
}