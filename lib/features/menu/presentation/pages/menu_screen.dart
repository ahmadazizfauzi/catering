import 'package:catering_1/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import '../widgets/section/list_menu_section.dart';
import 'package:catering_1/core/shared/modal/modal_alert.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
      appBar: AppBar(
        backgroundColor: AppColors.brand['default'],
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Meal Plans',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: AppColors.white['default'],
              ),
            ),
          ],
        ),
        centerTitle: true,
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
