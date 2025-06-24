import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class SloganHomeSection extends StatelessWidget {
  const SloganHomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '“Healthy Meals, Anytime, Anywhere”',
        style: TextStyle(
          fontSize: 22,
          fontStyle: FontStyle.italic,
          color: AppColors.brand['dark'],
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
