import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class AppbarShared extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final Widget? leading;
  final Widget? icon;
  final List<Widget>? actions;

  const AppbarShared({
    super.key,
    this.title = 'SEA Catering',
    this.backgroundColor,
    this.leading,
    this.icon,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.brand['default'],
      elevation: 0,
      leading: leading,
      automaticallyImplyLeading: false, // <-- tambahkan baris ini
      actions: actions,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? const SizedBox.shrink(),
          if (icon != null) const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: AppColors.white['default'],
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
