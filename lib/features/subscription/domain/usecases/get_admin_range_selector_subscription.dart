import '../entities/subscription.dart';
import '../repositories/subscription_repository.dart';

class GetAdminRangeSelectorSubscriptionUsecase {
  final SubscriptionRepository repository;

  GetAdminRangeSelectorSubscriptionUsecase(this.repository);

  Future<List<Subscription>> call(DateTime start, DateTime end) {
    return repository.getSubscriptionsByDateRange(start, end);
  }
}