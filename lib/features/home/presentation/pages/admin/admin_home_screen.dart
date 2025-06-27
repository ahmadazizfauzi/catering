import 'package:catering_1/core/shared/calender/calender_picker_shared.dart';
import 'package:catering_1/features/subscription/presentation/provider/admin/admin_subscription_provider.dart';
import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import 'package:catering_1/core/shared/appbar/appbar_shared.dart';
import 'package:catering_1/features/home/presentation/widgets/section/admin/admin_subscription_growth_section.dart';
import 'package:catering_1/features/home/presentation/widgets/section/admin/admin_card_total_subscription.dart';
import 'package:catering_1/features/home/presentation/widgets/section/admin/admin_card_total_mrr_subscription.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatefulWidget {
  final VoidCallback? onMenuPressed;

  const AdminHomeScreen({super.key, this.onMenuPressed});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List<DateTime?> _selectedDates = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final provider = Provider.of<AdminSubscriptionProvider>(
        // ignore: use_build_context_synchronously
        context,
        listen: false,
      );

      await provider.fetchAllTotals();
      await provider.fetchMonthlyRevenue();
      await provider.fetchAllSubscriptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brand['background'],
      appBar: AppbarShared(
        leading:
            widget.onMenuPressed != null
                ? IconButton(
                  icon: Icon(Icons.menu, color: AppColors.white['default']),
                  onPressed: widget.onMenuPressed,
                )
                : null,
        icon: Icon(
          Icons.admin_panel_settings,
          color: AppColors.white['default'],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AdminCardTotalSubscription(),
              const SizedBox(height: 16),
              const AdminCardTotalMRRSubscription(),
              const SizedBox(height: 16),
              CalenderPickerShared(
                initialValue: _selectedDates,
                onDateSelected: (dates) async {
                  setState(() {
                    _selectedDates = dates;
                  });
                  final provider = Provider.of<AdminSubscriptionProvider>(
                    context,
                    listen: false,
                  );
                  if (dates.length >= 2 &&
                      dates[0] != null &&
                      dates[1] != null) {
                    final start = DateTime(
                      dates[0]!.year,
                      dates[0]!.month,
                      dates[0]!.day,
                      0,
                      0,
                      0,
                    );
                    final end = DateTime(
                      dates[1]!.year,
                      dates[1]!.month,
                      dates[1]!.day,
                      23,
                      59,
                      59,
                    );
                    await provider.fetchSubscriptionsByRange(start, end);
                  } else if (dates.length == 1 && dates[0] != null) {
                    final start = DateTime(
                      dates[0]!.year,
                      dates[0]!.month,
                      dates[0]!.day,
                      0,
                      0,
                      0,
                    );
                    final end = DateTime(
                      dates[0]!.year,
                      dates[0]!.month,
                      dates[0]!.day,
                      23,
                      59,
                      59,
                    );
                    await provider.fetchSubscriptionsByRange(start, end);
                  } else {
                    await provider.fetchAllSubscriptions();
                  }
                },
                width: double.infinity,
              ),
              const SizedBox(height: 16),
              AdminSubscriptionGrowthSection(
                isFiltered:
                    _selectedDates.isNotEmpty && _selectedDates.first != null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
