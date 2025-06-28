import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class FilterUserSubscriptionSection extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final List<String> tabs;
  final MainAxisAlignment mainAxisAlignment;

  const FilterUserSubscriptionSection({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
    this.tabs = const ['Aktif', 'Pause'],
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween, 
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: List.generate(tabs.length, (i) {
        final isSelected = selectedIndex == i;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: GestureDetector(
            onTap: () => onChanged(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? AppColors.brand['default']
                        : Colors.transparent,
                border: Border.all(
                  color: AppColors.brand['default']!,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                tabs[i],
                style: TextStyle(
                  color:
                      isSelected
                          ? AppColors.white['default']
                          : AppColors.brand['default'],
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
