import 'package:catering_1/core/navigation/main_container.dart';
import 'package:catering_1/features/profile/presentation/pages/profile_screen.dart';
import 'package:catering_1/features/testimonial/presentation/pages/testimonial_screen.dart';
import 'package:catering_1/features/auth/presentation/pages/login_screen.dart';
import 'package:catering_1/features/auth/presentation/pages/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:catering_1/core/routes/app_routes.dart';

// Import halaman lain sesuai kebutuhan

class AppPages {
  static String get initial {
    final user = FirebaseAuth.instance.currentUser;
    // Jika sudah login (ada token), arahkan ke main, jika belum ke register
    return user != null ? AppRoutes.main : AppRoutes.register;
  }

  static final Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.main: (context) => MainContainer(),
    AppRoutes.register: (context) => RegisterScreen(),
    AppRoutes.login: (context) => LoginScreen(),
    AppRoutes.testimonial: (context) => TestimonialScreen(),
    AppRoutes.profile: (context) => ProfileScreen(),
  };
}
