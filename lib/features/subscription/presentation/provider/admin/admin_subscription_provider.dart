// ignore: file_names
import 'package:flutter/material.dart';
import '../../../domain/entities/subscription.dart';
import '../../../domain/usecases/get_admin_subscription_growth_usecase.dart';
import '../../../domain/usecases/get_admin_range_selector_subscription.dart';
import '../../../domain/usecases/get_admin_total_subscription_usecase.dart';

class AdminSubscriptionProvider extends ChangeNotifier {
  final GetAdminSubscriptionGrowthUsecase getAdminSubscriptionGrowthUsecase;
  final GetAdminRangeSelectorSubscriptionUsecase
  getAdminRangeSelectorSubscriptionUsecase;
  final GetAdminTotalSubscriptionUsecase getAdminTotalSubscriptionUsecase;

  AdminSubscriptionProvider(
    this.getAdminSubscriptionGrowthUsecase,
    this.getAdminRangeSelectorSubscriptionUsecase,
    this.getAdminTotalSubscriptionUsecase,
  );

  bool isLoading = false;
  String? message;
  List<Subscription> allSubscriptions = [];
  List<Subscription> rangeSubscriptions = [];
  int? totalAllSubscription;
  int? totalActiveSubscription;
  int? totalPauseSubscription;
  int? totalCancelSubscription;

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
      if (rangeSubscriptions.isEmpty) {}
      message = null;
    } catch (e) {
      message = "Failed to fetch subscriptions by range: $e";
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTotalSubscription({String? status}) async {
    isLoading = true;
    notifyListeners();
    try {
      totalAllSubscription = await getAdminTotalSubscriptionUsecase(
        status: status,
      );
      message = null;
    } catch (e) {
      message = "Failed to fetch total subscriptions: $e";
      totalAllSubscription = null;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAllTotals() async {
    isLoading = true;
    notifyListeners();
    try {
      totalAllSubscription = await getAdminTotalSubscriptionUsecase();
      totalActiveSubscription = await getAdminTotalSubscriptionUsecase(
        status: "aktif",
      );
      totalPauseSubscription = await getAdminTotalSubscriptionUsecase(
        status: "pause",
      );
      totalCancelSubscription = await getAdminTotalSubscriptionUsecase(
        status: "cancel",
      );
      message = null;
    } catch (e) {
      message = "Failed to fetch total subscriptions: $e";
      totalAllSubscription = null;
      totalActiveSubscription = null;
      totalPauseSubscription = null;
      totalCancelSubscription = null;
    }
    isLoading = false;
    notifyListeners();
  }
}
