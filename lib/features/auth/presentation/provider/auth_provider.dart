import 'package:flutter/material.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/entities/auth.dart';

class AuthProvider extends ChangeNotifier {
  final RegisterUsecase registerUsecase;

  bool isLoading = false;
  String? message;

  AuthProvider(this.registerUsecase);

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
}
