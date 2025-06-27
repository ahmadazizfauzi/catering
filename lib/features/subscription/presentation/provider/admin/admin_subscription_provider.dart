// ignore: file_names
import 'package:flutter/material.dart';
import '../../../domain/entities/subscription.dart';
import '../../../domain/usecases/get_admin_subscription_growth_usecase.dart';
import '../../../domain/usecases/get_admin_range_selector_subscription.dart';

class AdminSubscriptionProvider extends ChangeNotifier {
  final GetAdminSubscriptionGrowthUsecase getAdminSubscriptionGrowthUsecase;
  final GetAdminRangeSelectorSubscriptionUsecase
  getAdminRangeSelectorSubscriptionUsecase;

  AdminSubscriptionProvider(
    this.getAdminSubscriptionGrowthUsecase,
    this.getAdminRangeSelectorSubscriptionUsecase,
  );

  bool isLoading = false;
  String? message;
  List<Subscription> allSubscriptions = [];
  List<Subscription> rangeSubscriptions = [];

  Future<void> fetchAllSubscriptions() async {
    isLoading = true;
    notifyListeners();
    try {
      allSubscriptions = await getAdminSubscriptionGrowthUsecase();
      message = null;
    } catch (e) {
      message = "Failed to fetch subscriptions: $e";
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSubscriptionsByRange(DateTime start, DateTime end) async {
  isLoading = true;
  notifyListeners();
  try {
    rangeSubscriptions = await getAdminRangeSelectorSubscriptionUsecase(
      start,
      end,
    );
    if (rangeSubscriptions.isEmpty) {
    }
    message = null;
  } catch (e) {
    message = "Failed to fetch subscriptions by range: $e";
  }
  isLoading = false;
  notifyListeners();
}
}
