import 'package:flutter/material.dart';
import 'package:wanigo_ui/src/core/global_style/global_color.dart';
import 'package:wanigo_ui/src/core/global_style/global_icon.dart';
import 'package:wanigo_ui/src/core/global_style/global_shadow.dart';
import 'package:wanigo_ui/src/texts/global_text.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blue[500],
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue[500],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue[500],
          textStyle: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}