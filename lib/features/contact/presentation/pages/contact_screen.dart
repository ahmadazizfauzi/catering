import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class ContactScreen extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const ContactScreen({super.key, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brand['background'],
      appBar: AppBar(
        backgroundColor: AppColors.brand['default'],
        elevation: 0,
        leading:
            onMenuPressed != null
                ? IconButton(
                  icon: Icon(Icons.menu, color: AppColors.white['default']),
                  onPressed: onMenuPressed,
                )
                : null,
        title: Text('Contact Us', style: TextStyle(
          color: AppColors.white['default'],
        ),),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: AppColors.brand['light'],
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.phone_in_talk,
                    size: 64,
                    color: AppColors.brand['default'],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brand['dark'],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Bougas Catering',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.brand['default'],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Jl. Makanan Sehat No. 1\nJakarta, Indonesia',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.brand['text'],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: AppColors.brand['accent']),
                      const SizedBox(width: 8),
                      Text(
                        'info@bougascatering.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.brand['text'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: AppColors.brand['accent']),
                      const SizedBox(width: 8),
                      Text(
                        '+62 812-3456-7890',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.brand['text'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // ignore: deprecated_member_use
                  Divider(color: AppColors.brand['dark']!.withOpacity(0.2)),
                  const SizedBox(height: 8),
                  Text(
                    'Follow us on social media:',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.brand['text'],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.facebook, color: AppColors.brand['accent']),
                      const SizedBox(width: 12),
                      Icon(Icons.facebook, color: AppColors.brand['accent']),
                      const SizedBox(width: 12),
                      Icon(Icons.web, color: AppColors.brand['accent']),
                    ],
                  ),
                  const SizedBox(height: 28),
                  // Tombol "Beri Kami Rating"
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.star_rate_rounded,
                        color: Colors.amber[600],
                        size: 26,
                      ),
                      label: const Text(
                        "Beri Kami Rating",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brand['default'],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/testimonial');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
