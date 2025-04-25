import 'package:flutter/material.dart';

/// A global icon component that provides consistent icon rendering
/// across the app with predefined variants based on the design system.
class GlobalIcon extends StatelessWidget {
  final IconVariant variant; // Jenis ikon berdasarkan enum
  final IconType type; // Tipe ikon (active/disable)
  final double size; // Ukuran ikon
  final Color? color; // Warna overlay opsional

  const GlobalIcon({
    super.key,
    required this.variant,
    required this.type,
    this.size = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _getIconPath(),
      width: size,
      height: size,
      color: color,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Placeholder untuk ikon yang tidak ditemukan
        return Icon(
          Icons.error,
          size: size,
          color: color ?? Colors.red,
        );
      },
    );
  }

  /// Mengembalikan path ikon berdasarkan jenis dan tipe
  String _getIconPath() {
    final String state = type == IconType.active ? 'active' : 'disable';
    switch (variant) {
      case IconVariant.calendarItem:
        return 'assets/images/calendar-item/$state.png';
      case IconVariant.historyIcon:
        return 'assets/images/history-icon/$state.png';
      case IconVariant.homeIcon:
        return 'assets/images/home-icon/$state.png';
      case IconVariant.inbox:
        return 'assets/images/inbox/$state.png';
      case IconVariant.profileIcon:
        return 'assets/images/profile-icon/$state.png';
      case IconVariant.setoranIcon:
        return 'assets/images/setoran-icon/$state.png';
      case IconVariant.trendIcon:
        return 'assets/images/trend-icon/$state.png';
    }
  }
}

/// Enum untuk semua jenis ikon yang tersedia dalam aplikasi
enum IconVariant {
  calendarItem,
  historyIcon,
  homeIcon,
  inbox,
  profileIcon,
  setoranIcon,
  trendIcon,
}

/// Enum untuk menentukan tipe ikon (active atau disable)
enum IconType {
  active,
  disable,
}
