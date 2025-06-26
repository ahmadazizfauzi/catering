import '../repositories/subscription_repository.dart';

class UpdateStatusUserSubscriptionUsecase {
  final SubscriptionRepository repository;

  UpdateStatusUserSubscriptionUsecase(this.repository);

  Future<void> call(String id, String status) {
    return repository.updateStatus(id, status);
  }
}
