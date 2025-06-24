import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.react,
      backgroundColor: AppColors.brand['default'],
      activeColor: AppColors.white['default'],
      color: AppColors.brand['light'],
      items: const [
        TabItem(icon: Icons.home, title: 'Beranda'),
        TabItem(icon: Icons.restaurant_menu, title: 'Menu'),
        TabItem(icon: Icons.subscriptions, title: 'Subscription'),
        TabItem(icon: Icons.contact_phone, title: 'Contact'),
        // TabItem(icon: Icons.info_outline, title: 'About'),
      ],
      initialActiveIndex: currentIndex,
      onTap: onTap,
      elevation: 8,
      curveSize: 80,
    );
  }
}
