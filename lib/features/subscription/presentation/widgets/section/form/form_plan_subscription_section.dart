import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class FormPlanSubscriptionSection extends StatelessWidget {
  final String? selectedPlan;
  final Map<String, int> plans;
  final ValueChanged<String?> onChanged;

  const FormPlanSubscriptionSection({
    super.key,
    required this.selectedPlan,
    required this.plans,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Plan Selection *',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.brand['default'],
            fontSize: 16,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: plans.entries.map((e) {
            final isSelected = selectedPlan == e.key;
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.brand['light'] : AppColors.white['default'],
                  border: Border.all(
                    color: isSelected ? AppColors.brand['default']! : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.brand['default']!.withOpacity(0.12),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          )
                        ]
                      : [],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => onChanged(e.key),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                    child: Column(
                      children: [
                        Icon(
                          e.key == 'Diet Plan'
                              ? Icons.eco_rounded
                              : e.key == 'Protein Plan'
                                  ? Icons.fitness_center_rounded
                                  : Icons.emoji_events_rounded,
                          color: isSelected ? AppColors.brand['default'] : Colors.grey[400],
                          size: 28,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          e.key,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isSelected ? AppColors.brand['default'] : AppColors.brand['text'],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Rp${e.value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')},00',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: isSelected ? AppColors.brand['default'] : Colors.grey[600],
                            fontSize: 13,
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
        const SizedBox(height: 8),
      ],
    );
  }
}