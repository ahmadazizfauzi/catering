import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import 'package:catering_1/core/shared/button/button_shared.dart';

class CardMenuWidget extends StatelessWidget {
  final Map<String, String> plan;
  final VoidCallback onDetail;
  final String? statusText;
  final Future<void> Function()? onToggleStatus;

  const CardMenuWidget({
    super.key,
    required this.plan,
    required this.onDetail,
    this.statusText,
    this.onToggleStatus,
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
    String? toggleLabel;
    if (statusText?.toLowerCase() == 'aktif') {
      toggleLabel = 'Pause Subscription';
    } else if (statusText?.toLowerCase() == 'pause') {
      toggleLabel = 'Continue Subscription';
    }

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
                Stack(
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
                    
                    if (statusText != null && statusColor != null)
                      Positioned(
                        top: 12,
                        right: 12,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if ((statusText?.toLowerCase() == 'aktif' ||
                                    statusText?.toLowerCase() == 'pause') &&
                                onToggleStatus != null)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonShared(
                                    onPressed: onToggleStatus,
                                    text: toggleLabel ?? '',
                                    backgroundColor:
                                        statusText?.toLowerCase() == 'aktif'
                                            ? Colors.orange
                                            : AppColors.brand['default'],
                                    textColor: Colors.white,
                                    fontSize: 12,
                                    borderRadius: 8,
                                    leading:
                                        statusText?.toLowerCase() == 'aktif'
                                            ? const Icon(
                                              Icons.pause,
                                              size: 18,
                                              color: Colors.white,
                                            )
                                            : const Icon(
                                              Icons.play_arrow,
                                              size: 18,
                                              color: Colors.white,
                                            ),
                                  ),
                                  const SizedBox(width: 8),
                                  ButtonShared(
                                    onPressed:
                                        () {}, // Fungsi kosong untuk UI dulu
                                    text: 'Cancel',
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 12,
                                    borderRadius: 8,
                                    leading: const Icon(
                                      Icons.cancel,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            if (!(statusText?.toLowerCase() == 'aktif' ||
                                statusText?.toLowerCase() == 'pause'))
                              const SizedBox.shrink(),
                            const SizedBox(height: 8),
                             ButtonShared(
                              width: double.infinity,
                              onPressed: onDetail,
                              text: 'See More Details',
                              backgroundColor: AppColors.brand['default'],
                              textColor: Colors.white,
                              fontSize: 14,
                              borderRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
