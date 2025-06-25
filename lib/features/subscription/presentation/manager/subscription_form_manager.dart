import 'package:flutter/material.dart';
import '../../domain/entities/subscription.dart';
import '../data/subscription_data.dart';

class SubscriptionFormManager {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController allergyController = TextEditingController();

  String? selectedPlan;
  final List<String> mealTypes = [];
  final List<String> deliveryDays = [];

  String status = 'aktif'; // Tambahkan ini, default 'aktif'

  double get totalPrice {
    if (selectedPlan == null || mealTypes.isEmpty || deliveryDays.isEmpty) {
      return 0;
    }
    // Ganti dengan cara ambil harga plan sesuai kebutuhanmu
    final planPrice = plans[selectedPlan]!;
    return planPrice * mealTypes.length * deliveryDays.length * 4.3;
  }

  bool get isValid {
    return nameController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        selectedPlan != null &&
        mealTypes.isNotEmpty &&
        deliveryDays.isNotEmpty;
  }

  Subscription toEntity(String userId) {
    return Subscription(
      userId: userId,
      name: nameController.text,
      phone: phoneController.text,
      allergy: allergyController.text.isEmpty ? null : allergyController.text,
      plan: selectedPlan!,
      mealTypes: List<String>.from(mealTypes),
      deliveryDays: List<String>.from(deliveryDays),
      totalPrice: totalPrice,
      status: status, // Tambahkan ini
    );
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    allergyController.dispose();
  }
}
