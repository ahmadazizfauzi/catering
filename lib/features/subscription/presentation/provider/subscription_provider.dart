import 'package:flutter/material.dart';
import '../../domain/usecases/save_subscription_usecase.dart';
import '../../domain/usecases/get_user_subscription.dart';
import '../../domain/usecases/update_status_user_subscription_usecase.dart';
import '../../domain/entities/subscription.dart';

class SubscriptionProvider extends ChangeNotifier {
  final SaveSubscriptionUsecase saveSubscriptionUsecase;
  final GetUserSubscriptionUsecase getUserSubscriptionUsecase;
  final UpdateStatusUserSubscriptionUsecase updateStatusUserSubscriptionUsecase;

  bool isLoading = false;
  String? message;
  List<Subscription> userSubscriptions = [];

  SubscriptionProvider(
    this.saveSubscriptionUsecase,
    this.getUserSubscriptionUsecase,
    this.updateStatusUserSubscriptionUsecase,
  );

  Future<void> save(Subscription subscription, String userId) async {
    isLoading = true;
    message = null;
    notifyListeners();
    try {
      await saveSubscriptionUsecase(subscription, userId);
      message = "Subscription saved successfully!";
    } catch (e) {
      message = "Failed to save subscription: $e";
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUserSubscriptions(String userId) async {
    isLoading = true;
    notifyListeners();
    try {
      userSubscriptions = await getUserSubscriptionUsecase(userId);
      print(
        'Fetched subscriptions: ${userSubscriptions.length}',
      ); // Tambahkan print ini
      message = null;
    } catch (e) {
      message = "Failed to fetch subscriptions: $e";
    }
    isLoading = false;
    notifyListeners();
  }

    Future<void> updateStatus(String id, String status, String userId) async {
    isLoading = true;
    notifyListeners();
    try {
      await updateStatusUserSubscriptionUsecase(id, status);
      await fetchUserSubscriptions(userId); 
      message = "Status updated!";
    } catch (e) {
      message = "Failed to update status: $e";
    }
    isLoading = false;
    notifyListeners();
  }
}
