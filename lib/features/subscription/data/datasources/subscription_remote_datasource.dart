import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/subscription_model.dart';

class SubscriptionRemoteDatasource {
  final _collection = FirebaseFirestore.instance.collection('subscriptions');

  Future<void> addSubscription(
    SubscriptionModel subscription,
    String userId,
  ) async {
    await _collection.add({
      ...subscription.toMap(isNew: true),
      'userId': userId,
    });
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

  Future<List<SubscriptionModel>> getAllSubscriptions() async {
    final snapshot = await _collection.get();
    // ignore: unused_local_variable
    for (var doc in snapshot.docs) {}
    return snapshot.docs
        .map((doc) => SubscriptionModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<List<SubscriptionModel>> getSubscriptionsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final snapshot =
        await _collection
            .where(
              'createdAt',
              isGreaterThanOrEqualTo: Timestamp.fromDate(start),
            )
            .where('createdAt', isLessThanOrEqualTo: Timestamp.fromDate(end))
            .get();
    for (var doc in snapshot.docs) {
      doc.data();
    }
    return snapshot.docs
        .map((doc) => SubscriptionModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<double> getMonthlyRevenue({required DateTime month}) async {
    // Ambil tanggal awal dan akhir bulan
    final start = DateTime(month.year, month.month, 1, 0, 0, 0);
    final end = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

    final snapshot =
        await _collection
            .where(
              'createdAt',
              isGreaterThanOrEqualTo: Timestamp.fromDate(start),
            )
            .where('createdAt', isLessThanOrEqualTo: Timestamp.fromDate(end))
            .where('status', isEqualTo: 'aktif')
            .get();

    double total = 0;
    for (var doc in snapshot.docs) {
      final data = doc.data();
      if (data['totalPrice'] != null) {
        total += (data['totalPrice'] as num).toDouble();
      }
    }
    return total;
  }
}
