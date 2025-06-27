import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class GreetingHomeSection extends StatelessWidget {
  const GreetingHomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.brand['light'],
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(
            Icons.emoji_food_beverage,
            color: AppColors.brand['default'],
            size: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Selamat datang di SEA Catering!\n\nSEA Catering adalah layanan katering sehat yang dapat disesuaikan sesuai kebutuhan Anda, dengan pengantaran ke seluruh Indonesia. Nikmati makanan sehat, lezat, dan praktis kapan saja, di mana saja!',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.brand['text'],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
