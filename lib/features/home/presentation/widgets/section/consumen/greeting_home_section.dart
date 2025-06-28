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
              'Welcome to SEA Catering!\n\nSEA Catering is a healthy catering service that can be customized to your needs, with delivery throughout Indonesia. Enjoy healthy, delicious, and practical meals anytime, anywhere!',
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
