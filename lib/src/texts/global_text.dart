import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A global text component that provides consistent text styling across the app
/// with various predefined variants based on the design system.
class GlobalText extends StatelessWidget {
  final String text;
  final TextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;

  const GlobalText({
    super.key,
    required this.text,
    required this.variant,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getTextStyle().copyWith(decoration: decoration),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: true,
    );
  }

  TextStyle _getTextStyle() {
    switch (variant) {
      // Heading variants
      case TextVariant.h1:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 48.sp,
          height: 1.25, // 60/48 = 1.25
          fontWeight: FontWeight.w600,
          color: color,
        );
      case TextVariant.h2:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 40.sp,
          height: 1.2, // 48/40 = 1.2
          fontWeight: FontWeight.w600,
          color: color,
        );
      case TextVariant.h3:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 32.sp,
          height: 1.25, // 40/32 = 1.25
          fontWeight: FontWeight.w600,
          color: color,
        );
      case TextVariant.h4:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 24.sp,
          height: 1.25, // 30/24 = 1.25
          fontWeight: FontWeight.w600,
          color: color,
        );
      case TextVariant.h5:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 20.sp,
          height: 1.4, // 28/20 = 1.4
          fontWeight: FontWeight.w600,
          color: color,
        );
      case TextVariant.h6:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 18.sp,
          height: 1.4, // 25/18 = 1.4
          fontWeight: FontWeight.w600,
          color: color,
        );

      // Body variants - XSmall
      case TextVariant.xSmallRegular:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 12.sp,
          height: 1.29, // 15.5/12 = 1.29
          fontWeight: FontWeight.w400,
          color: color,
        );
      case TextVariant.xSmallMedium:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 12.sp,
          height: 1.29, // 15.5/12 = 1.29
          fontWeight: FontWeight.w500,
          color: color,
        );
      case TextVariant.xSmallSemiBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 12.sp,
          height: 1.29, // 15.5/12 = 1.29
          fontWeight: FontWeight.w600,
          color: color,
        );

      // Body variants - Small
      case TextVariant.smallRegular:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 14.sp,
          height: 1.29, // 18/14 = 1.29
          fontWeight: FontWeight.w400,
          color: color,
        );
      case TextVariant.smallMedium:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 14.sp,
          height: 1.29, // 18/14 = 1.29
          fontWeight: FontWeight.w500,
          color: color,
        );
      case TextVariant.smallSemiBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 14.sp,
          height: 1.29, // 18/14 = 1.29
          fontWeight: FontWeight.w600,
          color: color,
        );

      // Body variants - Medium
      case TextVariant.mediumRegular:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 16.sp,
          height: 1.25, // 20/16 = 1.25
          fontWeight: FontWeight.w400,
          color: color,
        );
      case TextVariant.mediumMedium:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 16.sp,
          height: 1.25, // 20/16 = 1.25
          fontWeight: FontWeight.w500,
          color: color,
        );
      case TextVariant.mediumSemiBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 16.sp,
          height: 1.25, // 20/16 = 1.25
          fontWeight: FontWeight.w600,
          color: color,
        );

      // Body variants - Large
      case TextVariant.largeRegular:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 18.sp,
          height: 1.28, // 23/18 = 1.28
          fontWeight: FontWeight.w400,
          color: color,
        );
      case TextVariant.largeMedium:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 18.sp,
          height: 1.28, // 23/18 = 1.28
          fontWeight: FontWeight.w500,
          color: color,
        );
      case TextVariant.largeSemiBold:
        return TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 18.sp,
          height: 1.28, // 23/18 = 1.28
          fontWeight: FontWeight.w600,
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

  // Body variants - XSmall (12/15.5)
  xSmallRegular,
  xSmallMedium,
  xSmallSemiBold,

  // Body variants - Small (14/18)
  smallRegular,
  smallMedium,
  smallSemiBold,

  // Body variants - Medium (16/20)
  mediumRegular,
  mediumMedium,
  mediumSemiBold,

  // Body variants - Large (18/23)
  largeRegular,
  largeMedium,
  largeSemiBold,
}
