import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/subscription_model.dart';

class SubscriptionRemoteDatasource {
  final _collection = FirebaseFirestore.instance.collection('subscriptions');

  Future<void> addSubscription(SubscriptionModel subscription) async {
    await _collection.add(subscription.toMap());
  }

  Future<List<SubscriptionModel>> getSubscriptions() async {
    final snapshot = await _collection.orderBy('createdAt', descending: true).get();
    return snapshot.docs
        .map((doc) => SubscriptionModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}