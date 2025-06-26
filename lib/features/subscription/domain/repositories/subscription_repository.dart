import '../entities/subscription.dart';

abstract class SubscriptionRepository {
  Future<void> saveSubscription(Subscription subscription, String userId);
  Future<List<Subscription>> getSubscriptions({String? userId});
  Future<void> updateStatus(String id, String status); // Tambahkan ini
}
