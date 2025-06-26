import '../entities/subscription.dart';
import '../repositories/subscription_repository.dart';

class GetUserSubscriptionUsecase {
  final SubscriptionRepository repository;

  GetUserSubscriptionUsecase(this.repository);

  Future<List<Subscription>> call(String userId) {
    return repository.getSubscriptions(userId: userId);
  }
}
