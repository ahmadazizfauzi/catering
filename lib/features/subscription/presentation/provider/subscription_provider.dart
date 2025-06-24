import 'package:flutter/material.dart';
import '../../domain/usecases/save_subscription_usecase.dart';
import '../../domain/entities/subscription.dart';

class SubscriptionProvider extends ChangeNotifier {
  final SaveSubscriptionUsecase saveSubscriptionUsecase;

  bool isLoading = false;
  String? message;

  SubscriptionProvider(this.saveSubscriptionUsecase);

  Future<void> save(Subscription subscription) async {
    isLoading = true;
    message = null;
    notifyListeners();
    try {
      await saveSubscriptionUsecase(subscription);
      message = "Subscription saved successfully!";
    } catch (e) {
      message = "Failed to save subscription: $e";
    }
    isLoading = false;
    notifyListeners();
  }
}