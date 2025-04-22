import 'dart:ui';
import 'package:flutter/material.dart';

class TColors {
  // Primary Colors
  static const Color appPrimaryColor = Color.fromRGBO(33, 150, 243, 1); // Blue from the screenshot
  static const Color appSecondaryColor = Color.fromRGBO(206, 236, 80, 1); // Original green color

  // Background Colors
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF5F5F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Color(0xFF9E9E9E);

  // Accent Colors
  static const Color accentBlue = Color(0xFF2196F3);
  static const Color accentGreen = Color(0xFF4CAF50);
  static const Color accentRed = Color(0xFFF44336);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2196F3),
      Color(0xFF1976D2),
    ],
  );

  // Utility Colors
  static const Color transparent = Color(0x00000000);
  static const Color overlay = Color(0x80000000);

  // Calendar Specific Colors
  static const Color calendarSelectedDay = Color(0xFF2196F3);
  static const Color calendarCurrentMonth = Colors.black;
  static const Color calendarOtherMonth = Color(0xFFE0E0E0);
}