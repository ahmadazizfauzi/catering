import '../entities/subscription.dart';
import '../repositories/subscription_repository.dart';

class SaveSubscriptionUsecase {
  final SubscriptionRepository repository;

  SaveSubscriptionUsecase(this.repository);

  Future<void> call({
    required String name,
    required String phone,
    String? allergy,
    required String plan,
    required List<String> mealTypes,
    required List<String> deliveryDays,
    required double totalPrice,
  }) {
    final subscription = Subscription(
      name: name,
      phone: phone,
      allergy: allergy,
      plan: plan,
      mealTypes: mealTypes,
      deliveryDays: deliveryDays,
      totalPrice: totalPrice,
    );
    return repository.saveSubscription(subscription);
  }
}