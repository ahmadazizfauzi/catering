import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class FormMealSubscriptionSection extends StatelessWidget {
  final List<String> mealTypes;
  final List<String> mealOptions;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;

  const FormMealSubscriptionSection({
    super.key,
    required this.mealTypes,
    required this.mealOptions,
    required this.onAdd,
    required this.onRemove,
  });

  IconData _mealIcon(String meal) {
    switch (meal) {
      case 'Breakfast':
        return Icons.free_breakfast_rounded;
      case 'Lunch':
        return Icons.lunch_dining_rounded;
      case 'Dinner':
        return Icons.nightlife_rounded;
      default:
        return Icons.restaurant_menu_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meal Type *',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.brand['default'],
            fontSize: 16,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: mealOptions.map((m) {
            final selected = mealTypes.contains(m);
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: selected ? AppColors.brand['light'] : AppColors.white['default'],
                  border: Border.all(
                    color: selected ? AppColors.brand['default']! : Colors.grey[300]!,
                    width: selected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: AppColors.brand['default']!.withOpacity(0.10),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          )
                        ]
                      : [],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    if (selected) {
                      onRemove(m);
                    } else {
                      onAdd(m);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _mealIcon(m),
                          color: selected ? AppColors.brand['default'] : Colors.grey[400],
                          size: 28,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          m,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: selected ? AppColors.brand['default'] : AppColors.brand['text'],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (mealTypes.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: Text(
              'Select at least one meal type',
              style: TextStyle(color: Colors.red[700], fontSize: 12),
            ),
          ),
      ],
    );
  }
}