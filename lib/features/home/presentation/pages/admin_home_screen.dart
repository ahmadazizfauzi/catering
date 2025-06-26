import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import 'package:catering_1/core/shared/appbar/appbar_shared.dart';

class AdminHomeScreen extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const AdminHomeScreen({super.key, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brand['background'],
      appBar: AppbarShared(
        leading: onMenuPressed != null
            ? IconButton(
                icon: Icon(Icons.menu, color: AppColors.white['default']),
                onPressed: onMenuPressed,
              )
            : null,
        icon: Icon(Icons.admin_panel_settings, color: AppColors.white['default']),
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
            Card(
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.people, color: AppColors.brand['default']),
                title: Text('Kelola User'),
                subtitle: Text('Lihat dan kelola data user aplikasi'),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.receipt_long, color: AppColors.brand['default']),
                title: Text('Kelola Subscription'),
                subtitle: Text('Pantau dan kelola semua subscription'),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.fastfood, color: AppColors.brand['default']),
                title: Text('Kelola Menu'),
                subtitle: Text('Tambah/edit menu catering'),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.analytics, color: AppColors.brand['default']),
                title: Text('Laporan & Statistik'),
                subtitle: Text('Lihat statistik penggunaan aplikasi'),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Selamat datang, Admin!',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.brand['text'],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}