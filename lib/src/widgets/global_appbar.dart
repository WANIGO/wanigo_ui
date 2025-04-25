import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final Color backgroundColor;
  final double elevation;
  final List<Widget>? actions;
  final double height;

  const GlobalAppBar({
    super.key,
    this.onBackPressed,
    this.showBackButton = true,
    this.backgroundColor = Colors.white,
    this.elevation = 0.5,
    this.actions,
    this.height = kToolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leadingWidth: kToolbarHeight,
      title: Image.asset(
        'packages/wanigo_ui/assets/images/appbar-logo.webp',
        height: 25.h,
        fit: BoxFit.contain,
      ),
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 24.sp,
              ),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}