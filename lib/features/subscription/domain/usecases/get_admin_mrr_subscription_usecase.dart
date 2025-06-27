import '../repositories/subscription_repository.dart';

class AdminGetMRRSubscriptionUsecase {
  final SubscriptionRepository repository;

  AdminGetMRRSubscriptionUsecase(this.repository);

  Future<double> call({DateTime? month}) {
    final now = month ?? DateTime.now();
    return repository.getMonthlyRevenue(now);
  }
}