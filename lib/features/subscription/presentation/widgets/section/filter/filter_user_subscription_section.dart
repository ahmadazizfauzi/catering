import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class FilterUserSubscriptionSection extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const FilterUserSubscriptionSection({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ['Aktif', 'Pause'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(tabs.length, (i) {
        final isSelected = selectedIndex == i;
        return SizedBox(
          width: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(tabs[i]),
              selected: isSelected,
              selectedColor: AppColors.brand['default'],
              backgroundColor: AppColors.white['default'],
              labelStyle: TextStyle(
                color:
                    isSelected
                        ? AppColors.white['default']
                        : AppColors.brand['default'],
                fontWeight: FontWeight.bold,
              ),
              showCheckmark: false,
              onSelected: (_) => onChanged(i),
            ),
          ),
        );
      }),
    );
  }
}
