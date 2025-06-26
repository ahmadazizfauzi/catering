import 'package:catering_1/core/colors/app_colors.dart';
import 'package:catering_1/core/routes/app_pages.dart';
import 'package:catering_1/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:catering_1/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:catering_1/features/auth/domain/usecases/login_usecase.dart';
import 'package:catering_1/features/auth/domain/usecases/logout_usecase.dart';
import 'package:catering_1/features/auth/domain/usecases/register_usecase.dart';
import 'package:catering_1/features/auth/presentation/provider/auth_provider.dart';
import 'package:catering_1/features/subscription/domain/usecases/get_user_subscription.dart';
import 'package:catering_1/features/subscription/domain/usecases/update_status_user_subscription_usecase.dart';
import 'package:catering_1/features/testimonial/data/datasources/testimonial_remote_datasource.dart';
import 'package:catering_1/features/testimonial/data/repositories/testimonial_repository_implementation.dart';
import 'package:catering_1/features/testimonial/domain/usecases/get_all_testimonial_usecase.dart';
import 'package:catering_1/features/testimonial/domain/usecases/save_testimonial_usecase.dart';
import 'package:catering_1/features/testimonial/presentation/pages/testimonial_screen.dart';
import 'package:catering_1/features/testimonial/presentation/provider/testimonial_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// Tambahkan import berikut:
import 'features/subscription/presentation/provider/subscription_provider.dart';
import 'features/subscription/domain/usecases/save_subscription_usecase.dart';
import 'features/subscription/data/repositories/subscription_repository_implementation.dart';
import 'features/subscription/data/datasources/subscription_remote_datasource.dart';
import 'features/profile/presentation/provider/profile_provider.dart';
import 'features/profile/domain/usecases/get_current_profile_usecase.dart';
import 'features/profile/data/repositories/profile_repository_implementation.dart';
import 'features/profile/data/datasources/profile_remote_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (_) => SubscriptionProvider(
                SaveSubscriptionUsecase(
                  SubscriptionRepositoryImplementation(
                    SubscriptionRemoteDatasource(),
                  ),
                ),
                GetUserSubscriptionUsecase(
                  SubscriptionRepositoryImplementation(
                    SubscriptionRemoteDatasource(),
                  ),
                ),
                UpdateStatusUserSubscriptionUsecase(
                  SubscriptionRepositoryImplementation(
                    SubscriptionRemoteDatasource(),
                  ),
                ),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (_) => AuthProvider(
                RegisterUsecase(
                  AuthRepositoryImplementation(AuthRemoteDatasource()),
                ),
                loginUsecase: LoginUsecase(
                  AuthRepositoryImplementation(AuthRemoteDatasource()),
                ),
                logoutUseCase: LogoutUseCase(
                  AuthRepositoryImplementation(AuthRemoteDatasource()),
                ),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (_) => TestimonialProvider(
                SaveTestimonialUsecase(
                  TestimonialRepositoryImplementation(
                    TestimonialRemoteDatasource(),
                  ),
                ),
                GetAllTestimonialUsecase(
                  TestimonialRepositoryImplementation(
                    TestimonialRemoteDatasource(),
                  ),
                ),
              ),
          child: TestimonialScreen(),
        ),
        // Tambahkan provider ProfileProvider di sini
        ChangeNotifierProvider(
          create:
              (_) => ProfileProvider(
                GetCurrentProfileUsecase(
                  ProfileRepositoryImplementation(ProfileRemoteDatasource()),
                ),
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bougas App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.white['default'],
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.white['default'],
          elevation: 0,
          foregroundColor: AppColors.black['default'],
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: AppColors.black['default'],
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          // ignore: deprecated_member_use
          background: AppColors.white['default'],
          surface: AppColors.white['default'],
        ),
        useMaterial3: true,
      ),
      initialRoute: AppPages.initial,
      debugShowCheckedModeBanner: false,
      routes: AppPages.routes,
    );
  }
}
