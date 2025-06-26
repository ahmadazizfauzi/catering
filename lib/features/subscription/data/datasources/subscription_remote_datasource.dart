import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/subscription_model.dart';

class SubscriptionRemoteDatasource {
  final _collection = FirebaseFirestore.instance.collection('subscriptions');

  Future<void> addSubscription(
    SubscriptionModel subscription,
    String userId,
  ) async {
    await _collection.add({...subscription.toMap(), 'userId': userId});
  }

  Future<List<SubscriptionModel>> getSubscriptions({String? userId}) async {
    Query query = _collection.orderBy('createdAt', descending: true);
    if (userId != null) {
      query = query.where('userId', isEqualTo: userId);
    }
    final snapshot = await query.get();
    return snapshot.docs
        .map(
          (doc) => SubscriptionModel.fromMap(
            doc.id,
            doc.data() as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<void> updateStatus(String id, String status) async {
    await _collection.doc(id).update({'status': status});
  }
}
