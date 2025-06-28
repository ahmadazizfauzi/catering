import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import 'package:catering_1/features/subscription/presentation/provider/admin/admin_subscription_provider.dart';

class AdminCardTotalSubscription extends StatelessWidget {
  const AdminCardTotalSubscription({super.key});

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.all_inbox_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Total Subscriptions",
                      style: TextStyle(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
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
                          "${provider.totalAllSubscription ?? 0}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StatusCount(
                      icon: Icons.check_circle_rounded,
                      label: "Active",
                      color: Colors.green[400]!,
                      count: provider.totalActiveSubscription ?? 0,
                    ),
                    const SizedBox(width: 16),
                    _StatusCount(
                      icon: Icons.pause_circle_filled_rounded,
                      label: "Pause",
                      color: Colors.orange[400]!,
                      count: provider.totalPauseSubscription ?? 0,
                    ),
                    const SizedBox(width: 16),
                    _StatusCount(
                      icon: Icons.cancel_rounded,
                      label: "Cancel",
                      color: Colors.red[400]!,
                      count: provider.totalCancelSubscription ?? 0,
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

class _StatusCount extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final int count;

  const _StatusCount({
    required this.icon,
    required this.label,
    required this.color,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 4),
        Text(
          "$count",
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(0.85),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
