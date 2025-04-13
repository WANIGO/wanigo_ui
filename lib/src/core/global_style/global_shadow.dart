import 'package:flutter/material.dart';

/// A global shadow component that provides consistent shadow styling across the app
class GlobalShadow {
  static List<BoxShadow> getShadow(ShadowVariant variant) {
    switch (variant) {
      case ShadowVariant.xSmall:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ];
      case ShadowVariant.small:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
        ];
      case ShadowVariant.medium:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ];
      case ShadowVariant.large:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ];
      case ShadowVariant.xLarge:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            offset: const Offset(0, 8),
            blurRadius: 16,
          ),
        ];
      case ShadowVariant.xxLarge:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 16),
            blurRadius: 24,
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
