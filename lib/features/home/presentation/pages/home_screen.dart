import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import '../widgets/section/slogan_home_section.dart';
import '../widgets/section/greeting_home_section.dart';
import '../widgets/section/service_home_section.dart';
import '../widgets/section/contact_home_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const HomeScreen({super.key, this.onMenuPressed});

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
                  icon: Icon(Icons.menu, color: AppColors.brand['accent']),
                  onPressed: onMenuPressed,
                )
                : null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant, color: AppColors.white['default']),
            const SizedBox(width: 8),
            Text(
              'SEA Catering',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: AppColors.white['default'],
              ),
            ),
          ],
        ),
        centerTitle: true,
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
