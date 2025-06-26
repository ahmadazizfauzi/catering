import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class CardMenuWidget extends StatelessWidget {
  final Map<String, String> plan;
  final VoidCallback onDetail;
  final String? statusText;

  const CardMenuWidget({
    super.key,
    required this.plan,
    required this.onDetail,
    this.statusText,
  });

  Color? getStatusColor() {
    if (statusText == null) return null;
    switch (statusText!.toLowerCase()) {
      case 'aktif':
        return Colors.green;
      case 'pause':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor();
    return Card(
      color: AppColors.white['default'],
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: Image.network(
                      (plan['image'] != null && plan['image']!.isNotEmpty)
                          ? plan['image']!
                          : 'https://picsum.photos/200/300',
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
            if (statusText != null && statusColor != null)
              Positioned(
                right: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    statusText!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
