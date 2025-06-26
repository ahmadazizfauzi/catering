import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import 'package:catering_1/core/shared/appbar/appbar_shared.dart';
import 'package:catering_1/core/routes/app_routes.dart';

class AdminHomeScreen extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const AdminHomeScreen({super.key, this.onMenuPressed});

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
        icon: Icon(
          Icons.admin_panel_settings,
          color: AppColors.white['default'],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Admin Portal',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.brand['dark'],
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.of(
                  context,
                ).pushNamed(AppRoutes.adminSubscriptionGrowth);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 28,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.brand['default'], // Warna hijau utama
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.brand['dark']!.withOpacity(0.08),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.analytics, color: Colors.white, size: 38),
                    const SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Laporan & Statistik',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Lihat statistik ',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Selamat datang, Admin!',
                style: TextStyle(fontSize: 16, color: AppColors.brand['text']),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
