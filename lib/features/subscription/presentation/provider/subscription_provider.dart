import 'package:flutter/material.dart';
import '../../domain/usecases/save_subscription_usecase.dart';

class SubscriptionProvider extends ChangeNotifier {
  final SaveSubscriptionUsecase saveSubscriptionUsecase;

  bool isLoading = false;
  String? message;

  SubscriptionProvider(this.saveSubscriptionUsecase);

  Future<void> save({
    required String name,
    required String phone,
    String? allergy,
    required String plan,
    required List<String> mealTypes,
    required List<String> deliveryDays,
    required double totalPrice,
  }) async {
    isLoading = true;
    message = null;
    notifyListeners();
    try {
      await saveSubscriptionUsecase(
        name: name,
        phone: phone,
        allergy: allergy,
        plan: plan,
        mealTypes: mealTypes,
        deliveryDays: deliveryDays,
        totalPrice: totalPrice,
      );
      message = "Subscription saved successfully!";
    } catch (e) {
      message = "Failed to save subscription: $e";
    }
    isLoading = false;
    notifyListeners();
  }
}