import '../entities/subscription.dart';
import '../repositories/subscription_repository.dart';

class SaveSubscriptionUsecase {
  final SubscriptionRepository repository;

  SaveSubscriptionUsecase(this.repository);

  Future<void> call(Subscription subscription, String userId) {
    return repository.saveSubscription(subscription, userId);
  }
}
