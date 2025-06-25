import 'package:catering_1/core/colors/app_colors.dart';
import 'package:catering_1/core/shared/appbar/appbar_shared.dart';
import 'package:flutter/material.dart';
import '../widgets/section/list_menu_section.dart';
import 'package:catering_1/core/shared/modal/modal_alert.dart';

class MenuScreen extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const MenuScreen({super.key, this.onMenuPressed});

  void _showDetails(BuildContext context, Map<String, String> plan) {
    showDialog(
      context: context,
      builder:
          (context) => ModalAlert(
            title: plan['name'] ?? 'Detail',
            content: plan['details'] ?? '-',
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brand['light'],
      appBar: AppbarShared(
        leading:
            onMenuPressed != null
                ? IconButton(
                  icon: Icon(Icons.menu, color: AppColors.white['default']),
                  onPressed: onMenuPressed,
                )
                : null,
        title: 'Meal Plans',
        icon: Icon(Icons.restaurant_menu, color: AppColors.white['default']),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(16.0),
          child: ListMenuSection(onDetail: _showDetails),
        ),
      ),
    );
  }
}
