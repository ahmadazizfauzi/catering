import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import 'package:catering_1/features/subscription/presentation/provider/admin/admin_subscription_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class AdminCardTotalMRRSubscription extends StatelessWidget {
  const AdminCardTotalMRRSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminSubscriptionProvider>(
      builder: (context, provider, _) {
        return Card(
          color: AppColors.brand['dark'],
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Row(
              children: [
                Icon(Icons.attach_money_rounded, color: Colors.white, size: 36),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Income This Month",
                      style: TextStyle(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    provider.isLoading
                        ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                        : Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp',
                            decimalDigits: 0,
                          ).format(provider.monthlyRevenue ?? 0),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
