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
          title: "Login Success",
          content: "Welcome back!",
          buttonText: "OK",
          status: "success",
          onClose: () {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/main');
          },
        );
      } else if (authProvider.message != null) {
        showModalAlert(
          // ignore: use_build_context_synchronously
          context: context,
          title: "Login Failed",
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.brand['light'],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_open,
                      size: 48,
                      color: AppColors.brand['default'],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.brand['dark'],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputTextShared(
                          controller: _formManager.emailController,
                          label: 'Email',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator:
                              (v) =>
                                  v == null || !v.contains('@')
                                      ? 'Invalid email'
                                      : null,
                        ),
                        const SizedBox(height: 16),
                        InputTextShared(
                          action: true,
                          controller: _formManager.passwordController,
                          label: 'Password',
                          icon: Icons.lock,
                          validator:
                              (v) =>
                                  v == null || v.length < 6
                                      ? 'Minimum 6 characters'
                                      : null,
                        ),
                        const SizedBox(height: 24),
                        ButtonShared(
                          width: double.infinity,
                          onPressed: _isLoading ? null : _submit,
                          text: 'Login',
                          isLoading: _isLoading,
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap:
                              () => Navigator.of(
                                context,
                              ).pushReplacementNamed('/register'),
                          child: Text(
                            "Don't have an account? Register",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.brand['accent'],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
