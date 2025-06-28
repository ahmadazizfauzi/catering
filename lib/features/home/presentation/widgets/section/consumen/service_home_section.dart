import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class ServiceHomeSection extends StatelessWidget {
  const ServiceHomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Featured Services:',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: AppColors.brand['default'],
          ),
        ),
        SizedBox(height: 14),
        FeatureItem(
          icon: Icons.restaurant_menu,
          text: 'Customize your menu to fit your nutritional needs',
        ),
        FeatureItem(
          icon: Icons.delivery_dining,
          text: 'Delivery to major cities across Indonesia',
        ),
        FeatureItem(
          icon: Icons.info_outline,
          text: 'Complete nutrition information for every menu',
        ),
      ],
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeatureItem({required this.icon, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: AppColors.brand['default']!.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: AppColors.brand['default']),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: AppColors.brand['text']),
            ),
          ),
        ],
      ),
    );
  }
}
