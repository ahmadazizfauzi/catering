import '../entities/subscription.dart';
import '../repositories/subscription_repository.dart';

class GetAdminSubscriptionGrowthUsecase {
  final SubscriptionRepository repository;

  GetAdminSubscriptionGrowthUsecase(this.repository);

  Future<List<Subscription>> call() {
    return repository.getAllSubscriptions();
  }
}