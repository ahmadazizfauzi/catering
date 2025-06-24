import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class CardMenuWidget extends StatelessWidget {
  final Map<String, String> plan;
  final VoidCallback onDetail;

  const CardMenuWidget({
    super.key,
    required this.plan,
    required this.onDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white['default'],
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (plan['image'] != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: Image.network(
                  plan['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan['name']!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brand['text'],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  plan['price']!,
                  style: TextStyle(
                    color: AppColors.brand['default'],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(plan['description']!),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brand['default'],
                    foregroundColor: AppColors.white['default'],
                  ),
                  onPressed: onDetail,
                  child: const Text('See More Details'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}