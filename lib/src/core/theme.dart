import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/src/core/global_style/global_color.dart';
import 'package:wanigo_ui/src/texts/global_text.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.blue500,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'NunitoSans',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blue500,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        textStyle: GlobalText(
          text: '',
          variant: TextVariant.mediumSemiBold,
          color: Colors.white,
        ).getTextStyle(), // Ubah ke method public
      ),
    ),
    iconTheme: IconThemeData(
      color: AppColors.blue500,
      size: 24.w,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blue500,
      elevation: 0,
      titleTextStyle: GlobalText(
        text: '',
        variant: TextVariant.h6,
        color: Colors.white,
      ).getTextStyle(), // Ubah ke method public
    ),
  );
}

// Jangan gunakan extension ini, karena tidak diperlukan lagi
// extension GlobalTextExtension on GlobalText {
//   TextStyle buildTextStyle() {
//     return _getTextStyle();
//   }
// }