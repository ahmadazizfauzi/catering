import 'package:flutter/material.dart';

class AuthFormManager {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool get isValid =>
      nameController.text.isNotEmpty &&
      emailController.text.contains('@') &&
      passwordController.text.length >= 6;
}