import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import 'package:catering_1/core/shared/appbar/appbar_shared.dart';
import '../../widgets/section/consumen/slogan_home_section.dart';
import '../../widgets/section/consumen/greeting_home_section.dart';
import '../../widgets/section/consumen/service_home_section.dart';
import '../../widgets/section/consumen/contact_home_section.dart';

class ConsumenHomeScreen extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const ConsumenHomeScreen({super.key, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brand['background'],
      appBar: AppbarShared(
        leading:
            onMenuPressed != null
                ? IconButton(
                  icon: Icon(Icons.menu, color: AppColors.white['default']),
                  onPressed: onMenuPressed,
                )
                : null,
        icon: Icon(Icons.restaurant, color: AppColors.white['default']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SloganHomeSection(),
            SizedBox(height: 28),
            GreetingHomeSection(),
            SizedBox(height: 32),
            ServiceHomeSection(),
            SizedBox(height: 36),
            ContactHomeSection(),
          ],
        ),
      ),
    );
  }
}
