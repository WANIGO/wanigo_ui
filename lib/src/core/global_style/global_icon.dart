import 'package:flutter/material.dart';

class AppIcons {
  // Ukuran ikon standar
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeExtraLarge = 48.0;

  // Ikon umum yang digunakan di seluruh aplikasi
  static const IconData home = Icons.home_outlined;
  static const IconData homeFilled = Icons.home;
  static const IconData search = Icons.search;
  static const IconData settings = Icons.settings_outlined;
  static const IconData settingsFilled = Icons.settings;
  static const IconData profile = Icons.person_outline;
  static const IconData profileFilled = Icons.person;
  static const IconData notification = Icons.notifications_none;
  static const IconData notificationFilled = Icons.notifications;
  static const IconData back = Icons.arrow_back;
  static const IconData forward = Icons.arrow_forward;
  static const IconData menu = Icons.menu;
  static const IconData close = Icons.close;
  static const IconData add = Icons.add;
  static const IconData remove = Icons.remove;
  static const IconData check = Icons.check;
  static const IconData error = Icons.error_outline;
  
  // Ikon khusus aplikasi (bisa ditambahkan sesuai kebutuhan)
  static const IconData logo = Icons.account_circle; // Ganti dengan ikon logo khusus
  static const IconData premium = Icons.star;
  static const IconData premiumFilled = Icons.star_rate;
  static const IconData download = Icons.download;
  static const IconData share = Icons.share;
}

class AppIcon extends StatelessWidget{
  final IconData icon;
  final double? size;
  final Color? color;
  final String? semanticLabel;

  const AppIcon({
    Key? key,
    required this.icon,
    this.size,
    this.color,
    this.semanticLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? AppIcons.iconSizeMedium,
      color: color ?? Theme.of(context).iconTheme.color,
      semanticLabel: semanticLabel,
    );
  }
}

