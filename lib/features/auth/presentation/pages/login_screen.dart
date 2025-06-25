import 'package:catering_1/core/shared/button/button_shared.dart';
import 'package:catering_1/core/shared/modal/modal_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/colors/app_colors.dart';
import '../manager/auth_form_manager.dart';
import '../../../../core/shared/input/input_text_shared.dart';
import 'package:catering_1/features/auth/presentation/provider/auth_provider.dart'
    as my_auth;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formManager = AuthFormManager();
  bool _isLoading = false;

  @override
  void dispose() {
    _formManager.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      final authProvider = Provider.of<my_auth.AuthProvider>(
        context,
        listen: false,
      );
      await authProvider.login(
        _formManager.emailController.text.trim(),
        _formManager.passwordController.text.trim(),
      );

      setState(() => _isLoading = false);

      if (authProvider.message?.contains("berhasil") == true) {
        showModalAlert(
          // ignore: use_build_context_synchronously
          context: context,
          title: "Login Berhasil",
          content: "Selamat datang kembali!",
          buttonText: "OK",
          status: "success",
          onClose: () {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/main'); // Ganti ke /home
          },
        );
      } else if (authProvider.message != null) {
        showModalAlert(
          // ignore: use_build_context_synchronously
          context: context,
          title: "Login Gagal",
          content: authProvider.message!,
          buttonText: "OK",
          status: "failed",
          onClose: () {
            Navigator.of(context).pop();
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brand['background'],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: AppColors.brand['light'],
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lock_open,
                      size: 64,
                      color: AppColors.brand['default'],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.brand['dark'],
                      ),
                    ),
                    const SizedBox(height: 24),
                    InputTextShared(
                      controller: _formManager.emailController,
                      label: 'Email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator:
                          (v) =>
                              v == null || !v.contains('@')
                                  ? 'Email tidak valid'
                                  : null,
                    ),
                    const SizedBox(height: 16),
                    InputTextShared(
                      controller: _formManager.passwordController,
                      label: 'Password',
                      icon: Icons.lock,
                      validator:
                          (v) =>
                              v == null || v.length < 6
                                  ? 'Minimal 6 karakter'
                                  : null,
                    ),
                    const SizedBox(height: 28),
                    ButtonShared(
                      onPressed: _isLoading ? null : _submit,
                      text: 'Masuk',
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/register');
                      },
                      child: Text(
                        'Belum punya akun? Daftar',
                        style: TextStyle(color: AppColors.brand['accent']),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
