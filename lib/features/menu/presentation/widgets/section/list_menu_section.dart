import 'package:flutter/material.dart';
import '../../data/menu_data.dart';
import '../component/card_menu_widget.dart';

class ListMenuSection extends StatelessWidget {
  final void Function(BuildContext, Map<String, String>) onDetail;

  const ListMenuSection({super.key, required this.onDetail});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mealPlans.length,
      itemBuilder: (context, index) {
        final plan = mealPlans[index];
        return CardMenuWidget(
          plan: plan,
          onDetail: () => onDetail(context, plan),
        );
      },
    );
  }
}