import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class ModalAlert extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final VoidCallback? onClose;
  final IconData icon;
  final Color? iconColor;

  const ModalAlert({
    super.key,
    required this.title,
    required this.content,
    this.buttonText = 'OK',
    this.onClose,
    this.icon = Icons.check_circle,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color modalGreen = AppColors.brand['modal']!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: (iconColor ?? modalGreen).withOpacity(0.1),
              radius: 32,
              child: Icon(
                icon,
                color: iconColor ?? modalGreen,
                size: 48,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.brand['text'],
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: modalGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                onPressed: onClose ?? () => Navigator.of(context).pop(),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}