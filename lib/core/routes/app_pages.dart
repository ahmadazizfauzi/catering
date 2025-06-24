import 'package:catering_1/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:catering_1/core/routes/app_routes.dart';

// Import halaman lain sesuai kebutuhan

class AppPages {
  static final Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.home:
        (context) => HomeScreen(
          onMenuPressed: () => Scaffold.of(context).openDrawer(),
        ),
  };
}
