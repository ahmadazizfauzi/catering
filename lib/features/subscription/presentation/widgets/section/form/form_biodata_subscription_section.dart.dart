import 'package:flutter/material.dart';
import 'package:catering_1/core/shared/input/input_text_shared.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class FormBiodataSubscriptionSection extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController phoneCtrl;

  const FormBiodataSubscriptionSection({
    super.key,
    required this.nameCtrl,
    required this.phoneCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Biodata',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.brand['default'],
            fontSize: 16,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Enter your full name and active phone number for payment and order updates.',
          style: TextStyle(color: AppColors.brand['text'], fontSize: 13),
        ),
        const SizedBox(height: 14),
        InputTextShared(
          controller: nameCtrl,
          label: 'Full Name *',
          icon: Icons.person,
          validator:
              (v) => v == null || v.trim().isEmpty ? 'Name required' : null,
        ),
        const SizedBox(height: 16),
        InputTextShared(
          controller: phoneCtrl,
          label: 'Active Phone Number *',
          keyboardType: TextInputType.phone,
          icon: Icons.phone,
          validator:
              (v) => v == null || v.trim().isEmpty ? 'Phone required' : null,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
