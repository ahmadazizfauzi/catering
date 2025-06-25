import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/main');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brand['light'],
      body: Center(
        child: Icon(
          Icons.restaurant_menu,
          size: 96,
          color: AppColors.brand['default'],
        ),
      ),
    );
  }
}
