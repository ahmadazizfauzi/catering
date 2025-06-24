import 'package:catering_1/core/navigation/main_container.dart';
import 'package:catering_1/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:catering_1/core/routes/app_routes.dart';

// Import halaman lain sesuai kebutuhan

class AppPages {
  static String get initial => AppRoutes.register;

  static final Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.main: (context) => MainContainer(),
    AppRoutes.register: (context) => RegisterScreen(),
  };
}
