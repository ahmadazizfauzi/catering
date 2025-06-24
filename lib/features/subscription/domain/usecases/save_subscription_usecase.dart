import '../entities/subscription.dart';
import '../repositories/subscription_repository.dart';

class SaveSubscriptionUsecase {
  final SubscriptionRepository repository;

  SaveSubscriptionUsecase(this.repository);

  Future<void> call(Subscription subscription) {
    return repository.saveSubscription(subscription);
  }
}