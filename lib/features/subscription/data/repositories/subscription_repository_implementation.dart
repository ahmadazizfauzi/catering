import '../../domain/entities/subscription.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../models/subscription_model.dart';
import '../datasources/subscription_remote_datasource.dart';

class SubscriptionRepositoryImplementation implements SubscriptionRepository {
  final SubscriptionRemoteDatasource remoteDatasource;

  SubscriptionRepositoryImplementation(this.remoteDatasource);

  @override
  Future<void> saveSubscription(Subscription subscription) {
    final model = SubscriptionModel.fromEntity(subscription);
    return remoteDatasource.addSubscription(model);
  }

  @override
  Future<List<Subscription>> getSubscriptions() async {
    final models = await remoteDatasource.getSubscriptions();
    return models.map((m) => m.toEntity()).toList();
  }
}