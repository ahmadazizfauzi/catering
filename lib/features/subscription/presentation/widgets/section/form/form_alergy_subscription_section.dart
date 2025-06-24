import 'package:flutter/material.dart';
import 'package:catering_1/core/shared/input/input_text_shared.dart';

class FormAlergySubscriptionSection extends StatelessWidget {
  final TextEditingController allergyCtrl;

  const FormAlergySubscriptionSection({super.key, required this.allergyCtrl});

  @override
  Widget build(BuildContext context) {
    return InputTextShared(
      controller: allergyCtrl,
      label: 'Allergies (optional)',
      icon: Icons.warning_amber_rounded,
    );
  }
}