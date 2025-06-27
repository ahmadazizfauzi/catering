import '../../domain/entities/subscription.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../models/subscription_model.dart';
import '../datasources/subscription_remote_datasource.dart';

class SubscriptionRepositoryImplementation implements SubscriptionRepository {
  final SubscriptionRemoteDatasource remoteDatasource;

  SubscriptionRepositoryImplementation(this.remoteDatasource);

  @override
  Future<void> saveSubscription(Subscription subscription, String userId) {
    final model = SubscriptionModel.fromEntity(subscription);
    return remoteDatasource.addSubscription(model, userId);
  }

  @override
  Future<List<Subscription>> getSubscriptions({String? userId}) async {
    final models = await remoteDatasource.getSubscriptions(userId: userId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> updateStatus(String id, String status) {
    return remoteDatasource.updateStatus(id, status);
  }

   @override
  Future<List<Subscription>> getAllSubscriptions() async {
    final models = await remoteDatasource.getAllSubscriptions();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Subscription>> getSubscriptionsByDateRange(DateTime start, DateTime end) async {
    final models = await remoteDatasource.getSubscriptionsByDateRange(start, end);
    return models.map((m) => m.toEntity()).toList();
  }
}
