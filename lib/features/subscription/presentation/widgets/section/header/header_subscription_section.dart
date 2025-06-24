import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class HeaderSubscriptionSection extends StatelessWidget {
  const HeaderSubscriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      decoration: BoxDecoration(
        color: AppColors.brand['light'],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.brand['default']!.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.emoji_food_beverage_rounded,
            color: AppColors.brand['default'],
            size: 36,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Join Our Meal Subscription!',
                  style: TextStyle(
                    color: AppColors.brand['default'],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Enjoy the convenience of healthy eating without hassle. Choose your plan, set your schedule, and get delicious meals delivered to your door every week!',
                  style: TextStyle(
                    color: AppColors.brand['text'],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
