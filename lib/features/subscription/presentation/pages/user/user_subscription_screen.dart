import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catering_1/features/subscription/presentation/provider/consumen/consumen_subscription_provider.dart';
import 'package:catering_1/features/menu/presentation/widgets/component/card_menu_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:catering_1/features/subscription/presentation/widgets/section/filter/filter_user_subscription_section.dart';

class UserSubscriptionScreen extends StatefulWidget {
  final VoidCallback? onMenuPressed;

  const UserSubscriptionScreen({super.key, this.onMenuPressed});

  @override
  State<UserSubscriptionScreen> createState() => _UserSubscriptionScreenState();
}

class _UserSubscriptionScreenState extends State<UserSubscriptionScreen> {
  int _selectedTab = 0;
  final List<String> _tabStatus = ['aktif', 'pause', 'cancel'];

  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (userId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<ConsumenSubscriptionProvider>().fetchUserSubscriptions(userId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ConsumenSubscriptionProvider>();
    final subscriptions = provider.userSubscriptions;
    final filtered =
        subscriptions
            .where(
              (sub) => sub.status.toLowerCase() == _tabStatus[_selectedTab],
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Subscriptions'),
        leading:
            widget.onMenuPressed != null
                ? IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: widget.onMenuPressed,
                )
                : null,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FilterUserSubscriptionSection(
              mainAxisAlignment: MainAxisAlignment.start,
              selectedIndex: _selectedTab,
              onChanged: (i) => setState(() => _selectedTab = i),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child:
                provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : filtered.isEmpty
                    ? const Center(child: Text('Tidak ada data.'))
                    : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final sub = filtered[index];
                        final plan = {
                          'name': sub.plan,
                          'price': 'Rp${sub.totalPrice.toStringAsFixed(0)}',
                          'description':
                              'Meal: ${sub.mealTypes.join(', ')}\nHari: ${sub.deliveryDays.join(', ')}',
                        };
                        return CardMenuWidget(
                          plan: plan,
                          statusText: sub.status,
                          onToggleStatus: () async {
                            final userId =
                                FirebaseAuth.instance.currentUser?.uid ?? '';
                            if (userId.isEmpty) return;
                            final provider =
                                context.read<ConsumenSubscriptionProvider>();
                            final newStatus =
                                sub.status.toLowerCase() == 'aktif'
                                    ? 'pause'
                                    : 'aktif';
                            await provider.updateStatus(
                              sub.id!,
                              newStatus,
                              userId,
                            );
                          },
                          onCancel: () async {
                            final userId =
                                FirebaseAuth.instance.currentUser?.uid ?? '';
                            if (userId.isEmpty) return;
                            final provider =
                                context.read<ConsumenSubscriptionProvider>();
                            await provider.updateStatus(
                              sub.id!,
                              'cancel',
                              userId,
                            );
                          },
                          onDetail: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => AlertDialog(
                                    title: Text(sub.plan),
                                    content: Text(
                                      'Nama: ${sub.name}\n'
                                      'No HP: ${sub.phone}\n'
                                      'Allergy: ${sub.allergy ?? "-"}\n'
                                      'Meal: ${sub.mealTypes.join(', ')}\n'
                                      'Hari: ${sub.deliveryDays.join(', ')}\n'
                                      'Status: ${sub.status}',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Tutup'),
                                      ),
                                    ],
                                  ),
                            );
                          },
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
