import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class FormDeliverySubscriptionSection extends StatelessWidget {
  final List<String> deliveryDays;
  final List<String> days;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;

  const FormDeliverySubscriptionSection({
    super.key,
    required this.deliveryDays,
    required this.days,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Days *',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.brand['default']),
        ),
        Wrap(
          spacing: 8,
          children: days.map((d) => FilterChip(
            label: Text(d),
            selected: deliveryDays.contains(d),
            selectedColor: AppColors.brand['light'],
            checkmarkColor: AppColors.brand['default'],
            onSelected: (val) {
              if (val) {
                onAdd(d);
              } else {
                onRemove(d);
              }
            },
          )).toList(),
        ),
        if (deliveryDays.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4, bottom: 8),
            child: Text(
              'Select at least one day',
              style: TextStyle(color: Colors.red[700], fontSize: 12),
            ),
          ),
      ],
    );
  }
}