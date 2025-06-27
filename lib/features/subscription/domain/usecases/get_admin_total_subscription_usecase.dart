import '../repositories/subscription_repository.dart';

class GetAdminTotalSubscriptionUsecase {
  final SubscriptionRepository repository;

  GetAdminTotalSubscriptionUsecase(this.repository);

  /// Get total subscriptions, optionally filtered by status.
  Future<int> call({String? status}) async {
    final all = await repository.getAllSubscriptions();
    if (status != null) {
      return all
          .where((sub) => sub.status.toLowerCase() == status.toLowerCase())
          .length;
    }
    return all.length;
  }
}
