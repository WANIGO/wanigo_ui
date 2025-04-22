import 'package:flutter/material.dart';

/// A global shadow component that provides consistent shadow styling across the app
class GlobalShadow {
  static List<BoxShadow> getShadow(ShadowVariant variant) {
    switch (variant) {
      case ShadowVariant.xSmall:
        return [
          BoxShadow(
            color: const Color(0xFF0D0D12).withAlpha(15), // 0.06 opacity
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ];
      case ShadowVariant.small:
        return [
          BoxShadow(
            color: const Color(0xFF0D0D12).withAlpha(13), // 0.05 opacity
            offset: const Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color(0xFF0D0D12).withAlpha(10), // 0.04 opacity
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ];
      case ShadowVariant.medium:
        return [
          BoxShadow(
            color: const Color(0xFF0D0D12).withAlpha(10), // 0.04 opacity
            offset: const Offset(0, 5),
            blurRadius: 10,
            spreadRadius: -2,
          ),
          BoxShadow(
            color: const Color(0xFF0D0D12).withAlpha(5), // 0.02 opacity
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: -1,
          ),
        ];
      case ShadowVariant.large:
        return [
          BoxShadow(
            color: const Color(0xFF0D0D12).withAlpha(20), // 0.08 opacity
            offset: const Offset(0, 12),
            blurRadius: 16,
            spreadRadius: -4,
          ),
          BoxShadow(
            color: const Color(0xFF0D0D12).withAlpha(8), // 0.03 opacity
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -2,
          ),
        ];
      case ShadowVariant.xLarge:
        return [
          BoxShadow(
            color: const Color(0xFF0D0D12).withAlpha(31), // 0.12 opacity
            offset: const Offset(0, 24),
            blurRadius: 48,
            spreadRadius: -12,
          ),
        ];
      case ShadowVariant.xxLarge:
        return [
          BoxShadow(
            color: const Color(0xFF0D0D12).withAlpha(46), // 0.18 opacity
            offset: const Offset(0, 24),
            blurRadius: 48,
            spreadRadius: -12,
          ),
        ];
    }
  }
}

/// Enum for all shadow variants available in the app
enum ShadowVariant {
  xSmall,
  small,
  medium,
  large,
  xLarge,
  xxLarge
}