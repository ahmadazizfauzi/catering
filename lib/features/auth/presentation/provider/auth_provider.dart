import 'package:flutter/material.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart'; // Tambahkan ini
import '../../domain/entities/auth.dart';

class AuthProvider extends ChangeNotifier {
  final RegisterUsecase registerUsecase;
  final LoginUsecase? loginUsecase;
  final LogoutUseCase? logoutUseCase; // Tambahkan ini

  bool isLoading = false;
  String? message;
  Auth? currentUser;

  AuthProvider(
    this.registerUsecase, {
    this.loginUsecase,
    this.logoutUseCase, // Tambahkan ini
  });

  Future<void> register(Auth auth, String password) async {
    isLoading = true;
    message = null;
    notifyListeners();
    try {
      await registerUsecase(auth, password);
      message = "Register berhasil!";
    } catch (e) {
      message = "Register gagal: $e";
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    if (logoutUseCase == null) return;
    isLoading = true;
    message = null;
    notifyListeners();
    try {
      await logoutUseCase!();
      currentUser = null;
      message = "Logout berhasil!";
    } catch (e) {
      message = "Logout gagal: $e";
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    if (loginUsecase == null) return;
    isLoading = true;
    message = null;
    notifyListeners();
    try {
      currentUser = await loginUsecase!(email, password);
      message = "Login berhasil!";
    } catch (e) {
      message = "Login gagal: $e";
    }
    isLoading = false;
    notifyListeners();
  }
}
