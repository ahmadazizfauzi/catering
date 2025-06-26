import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catering_1/features/subscription/presentation/provider/subscription_provider.dart';
import 'package:catering_1/features/menu/presentation/widgets/component/card_menu_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSubscriptionScreen extends StatefulWidget {
  final VoidCallback? onMenuPressed;

  const UserSubscriptionScreen({super.key, this.onMenuPressed});

  @override
  State<UserSubscriptionScreen> createState() => _UserSubscriptionScreenState();
}

class _UserSubscriptionScreenState extends State<UserSubscriptionScreen> {
  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    print('Current userId: $userId'); // Tambahkan print ini
    if (userId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<SubscriptionProvider>().fetchUserSubscriptions(userId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubscriptionProvider>();
    final subscriptions = provider.userSubscriptions;

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
      body:
          provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : subscriptions.isEmpty
              ? const Center(child: Text('Belum ada subscription.'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: subscriptions.length,
                itemBuilder: (context, index) {
                  final sub = subscriptions[index];
                  // CardMenuWidget expects Map<String, String>
                  final plan = {
                    'name': sub.plan,
                    'price': 'Rp${sub.totalPrice.toStringAsFixed(0)}',
                    'description':
                        'Meal: ${sub.mealTypes.join(', ')}\nHari: ${sub.deliveryDays.join(', ')}',
                    'image': '', // Kosongkan atau isi jika ada gambar
                  };
                  return Stack(
                    children: [
                      CardMenuWidget(
                        plan: plan,
                        statusText: "pause",
                        onDetail: () {
                          // Bisa tampilkan detail subscription jika mau
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
                      ),
                    ],
                  );
                },
              ),
    );
  }
}
