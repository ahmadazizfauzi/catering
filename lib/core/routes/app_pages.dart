import 'package:catering_1/core/navigation/main_container.dart';
import 'package:catering_1/features/profile/presentation/pages/profile_screen.dart';
import 'package:catering_1/features/subscription/presentation/pages/user/user_subscription_screen.dart';
import 'package:catering_1/features/testimonial/presentation/pages/testimonial_screen.dart';
import 'package:catering_1/features/auth/presentation/pages/login_screen.dart';
import 'package:catering_1/features/auth/presentation/pages/register_screen.dart';
import 'package:catering_1/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:catering_1/core/routes/app_routes.dart';

class AppPages {
  static String get initial {
    return AppRoutes.splash;
  }

  static final Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.splash: (context) => const SplashScreen(), 
    AppRoutes.main: (context) => MainContainer(),
    AppRoutes.register: (context) => RegisterScreen(),
    AppRoutes.login: (context) => LoginScreen(),
    AppRoutes.testimonial: (context) => TestimonialScreen(),
    AppRoutes.profile: (context) => ProfileScreen(),
    AppRoutes.userSubscription: (context) => UserSubscriptionScreen(),
  };
}
