import 'package:catering_1/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart'; 
class DropdownShared extends StatelessWidget {
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String hint;
  final bool isExpanded;
  final double? width;
  final EdgeInsets? contentPadding;
  final BoxBorder? border;

  const DropdownShared({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint = 'Select an option',
    this.isExpanded = false,
    this.width,
    this.contentPadding,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: AppColors.white['off'],
        borderRadius: BorderRadius.circular(8),
        border: border,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: AppColors.brand['default']!.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 12),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: value,
            isExpanded: isExpanded,
            style: TextStyle(color: AppColors.black['default'], fontSize: 14),
            hint: Text(
              hint,
              style: TextStyle(color: AppColors.brand['default'], fontSize: 14),
            ),
            onChanged: onChanged,
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.white['default'],
              ),
              elevation: 3,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 48,
            ),
          ),
        ),
      ),
    );
  }
}