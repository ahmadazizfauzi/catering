import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catering_1/features/subscription/presentation/provider/admin/admin_subscription_provider.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class AdminSubscriptionGrowthSection extends StatefulWidget {
  final bool isFiltered;
  const AdminSubscriptionGrowthSection({super.key, this.isFiltered = false});

  @override
  State<AdminSubscriptionGrowthSection> createState() =>
      _AdminSubscriptionGrowthSectionState();
}

class _AdminSubscriptionGrowthSectionState
    extends State<AdminSubscriptionGrowthSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminSubscriptionProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final data =
            widget.isFiltered
                ? provider.rangeSubscriptions
                : provider.allSubscriptions;

        data.sort((a, b) {
          if (a.createdAt == null && b.createdAt == null) return 0;
          if (a.createdAt == null) return 1;
          if (b.createdAt == null) return -1;
          return b.createdAt!.compareTo(a.createdAt!);
        });
        if (data.isEmpty) {
          return const Center(child: Text("Belum ada subscription aktif."));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          itemCount: data.length,
          itemBuilder: (context, i) {
            final sub = data[i];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.white['default'],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: AppColors.brand['dark']!.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sub.plan,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.brand['default'],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 18,
                          color: AppColors.brand['default'],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          sub.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.brand['text'],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.phone,
                          size: 18,
                          color: AppColors.brand['default'],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          sub.phone,
                          style: TextStyle(color: AppColors.brand['text']),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: AppColors.brand['default'],
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "Delivery: ${sub.deliveryDays.join(', ')}",
                            style: TextStyle(fontSize: 13),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.restaurant_menu,
                          size: 16,
                          color: AppColors.brand['default'],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Meal Types: ${sub.mealTypes.join(', ')}",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.warning_amber,
                          size: 16,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Alergi: ${sub.allergy ?? '-'}",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 16,
                          color: AppColors.brand['default'],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Total: Rp${sub.totalPrice.toString()}",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(sub.status),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            sub.status,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 16,
                          color: AppColors.brand['default'],
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Created at: ${sub.createdAt != null ? _formatDate(sub.createdAt) : '-'}",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'aktif':
        return Colors.green;
      case 'pause':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    final months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final month = months[date.month];
    final day = date.day.toString().padLeft(2, '0');
    final year = date.year;
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return "$month $day $year, $hour:$minute";
  }
}
