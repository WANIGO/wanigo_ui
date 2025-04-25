import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A global text component that provides consistent text styling across the app
/// with optional font size customization.
class GlobalText extends StatelessWidget {
  final String text;
  final TextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? fontSize; // Custom font size override

  const GlobalText({
    super.key,
    required this.text,
    required this.variant,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyle().copyWith(decoration: decoration),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: true,
    );
  }

  TextStyle getTextStyle() {
    switch (variant) {
      // Heading variants
      case TextVariant.h1:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 48.sp,
          height: 1.25,
          fontWeight: FontWeight.w600,
          color: color,
        );
      case TextVariant.h2:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 40.sp,
          height: 1.2,
          fontWeight: FontWeight.w600,
          color: color,
        );
      case TextVariant.h3:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 32.sp,
          height: 1.25,
          fontWeight: FontWeight.w600,
          color: color,
        );
      case TextVariant.h4:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 24.sp,
          height: 1.25,
          fontWeight: FontWeight.w600,
          color: color,
        );
      case TextVariant.h5:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 20.sp,
          height: 1.4,
          fontWeight: FontWeight.w600,
          color: color,
        );
      case TextVariant.h6:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 18.sp,
          height: 1.4,
          fontWeight: FontWeight.w600,
          color: color,
        );

      // Body variants - XSmall
      case TextVariant.xSmallRegular:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 12.sp,
          height: 1.29,
          fontWeight: FontWeight.w400,
          color: color,
        );
      case TextVariant.xSmallMedium:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 12.sp,
          height: 1.29,
          fontWeight: FontWeight.w500,
          color: color,
        );
      case TextVariant.xSmallSemiBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 12.sp,
          height: 1.29,
          fontWeight: FontWeight.w600,
          color: color,
        );
      case TextVariant.xSmallBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 12.sp,
          height: 1.29,
          fontWeight: FontWeight.w700,
          color: color,
        );
      case TextVariant.xSmallExtraBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 12.sp,
          height: 1.29,
          fontWeight: FontWeight.w800,
          color: color,
        );

      // Body variants - Small
      case TextVariant.smallRegular:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 14.sp,
          height: 1.29,
          fontWeight: FontWeight.w400,
          color: color,
        );
      case TextVariant.smallMedium:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 14.sp,
          height: 1.29,
          fontWeight: FontWeight.w500,
          color: color,
        );
      case TextVariant.smallSemiBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 14.sp,
          height: 1.29,
          fontWeight: FontWeight.w600,
          color: color,
        );
      case TextVariant.smallBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 14.sp,
          height: 1.29,
          fontWeight: FontWeight.w700,
          color: color,
        );
      case TextVariant.smallExtraBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 14.sp,
          height: 1.29,
          fontWeight: FontWeight.w800,
          color: color,
        );

      // Body variants - Medium
      case TextVariant.mediumRegular:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 16.sp,
          height: 1.25,
          fontWeight: FontWeight.w400,
          color: color,
        );
      case TextVariant.mediumMedium:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 16.sp,
          height: 1.25,
          fontWeight: FontWeight.w500,
          color: color,
        );
      case TextVariant.mediumSemiBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 16.sp,
          height: 1.25,
          fontWeight: FontWeight.w600,
          color: color,
        );
      case TextVariant.mediumBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 16.sp,
          height: 1.25,
          fontWeight: FontWeight.w700,
          color: color,
        );
      case TextVariant.mediumExtraBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 16.sp,
          height: 1.25,
          fontWeight: FontWeight.w800,
          color: color,
        );

      // Body variants - Large
      case TextVariant.largeRegular:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 18.sp,
          height: 1.28,
          fontWeight: FontWeight.w400,
          color: color,
        );
      case TextVariant.largeMedium:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 18.sp,
          height: 1.28,
          fontWeight: FontWeight.w500,
          color: color,
        );
      case TextVariant.largeSemiBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 18.sp,
          height: 1.28,
          fontWeight: FontWeight.w600,
          color: color,
        );
      case TextVariant.largeBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 18.sp,
          height: 1.28,
          fontWeight: FontWeight.w700,
          color: color,
        );
      case TextVariant.largeExtraBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: fontSize ?? 18.sp,
          height: 1.28,
          fontWeight: FontWeight.w800,
          color: color,
        );
    }
  }
}

/// Enum for all text variants available in the app
enum TextVariant {
  // Heading variants
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,

  // Body variants - XSmall
  xSmallRegular,
  xSmallMedium,
  xSmallSemiBold,
  xSmallBold,
  xSmallExtraBold,

  // Body variants - Small
  smallRegular,
  smallMedium,
  smallSemiBold,
  smallBold,
  smallExtraBold,

  // Body variants - Medium
  mediumRegular,
  mediumMedium,
  mediumSemiBold,
  mediumBold,
  mediumExtraBold,

  // Body variants - Large
  largeRegular,
  largeMedium,
  largeSemiBold,
  largeBold,
  largeExtraBold,
}
