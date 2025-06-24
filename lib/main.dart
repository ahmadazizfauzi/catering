import 'package:catering_1/core/colors/app_colors.dart';
import 'package:catering_1/core/navigation/main_container.dart';
import 'package:catering_1/core/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// Tambahkan import berikut:
import 'features/subscription/presentation/provider/subscription_provider.dart';
import 'features/subscription/domain/usecases/save_subscription_usecase.dart';
import 'features/subscription/data/repositories/subscription_repository_implementation.dart';
import 'features/subscription/data/datasources/subscription_remote_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SubscriptionProvider(
            SaveSubscriptionUsecase(
              SubscriptionRepositoryImplementation(
                SubscriptionRemoteDatasource(),
              ),
            ),
          ),
        ),
        // Tambahkan provider lain di sini jika perlu
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
          background: AppColors.white['default'],
          surface: AppColors.white['default'],
        ),
        useMaterial3: true,
      ),
      home: const MainContainer(),
      debugShowCheckedModeBanner: false,
      routes: AppPages.routes,
    );
  }
}