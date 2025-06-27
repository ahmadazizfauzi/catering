import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class ContactHomeSection extends StatelessWidget {
  const ContactHomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hubungi Kami',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.brand['default'],
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: AppColors.brand['light'],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, color: AppColors.brand['default']),
                    const SizedBox(width: 8),
                    Text(
                      'Manager: Brian',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.brand['text'],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.phone, color: AppColors.brand['default']),
                    const SizedBox(width: 8),
                    Text(
                      '08123456789',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.brand['text'],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
