import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/subscription.dart';

class SubscriptionModel {
  final String? id;
  final String userId;
  final String name;
  final String phone;
  final String? allergy;
  final String plan;
  final List<String> mealTypes;
  final List<String> deliveryDays;
  final double totalPrice;
  final String status;
  final DateTime? createdAt; 

  SubscriptionModel({
    this.id,
    required this.userId,
    required this.name,
    required this.phone,
    this.allergy,
    required this.plan,
    required this.mealTypes,
    required this.deliveryDays,
    required this.totalPrice,
    this.status = 'aktif',
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'phone': phone,
      'allergy': allergy,
      'plan': plan,
      'mealTypes': mealTypes,
      'deliveryDays': deliveryDays,
      'totalPrice': totalPrice,
      'status': status,
      'createdAt': createdAt, // Biarkan Firestore handle jika null
    };
  }

  factory SubscriptionModel.fromMap(String id, Map<String, dynamic> map) {
    return SubscriptionModel(
      id: id,
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      allergy: map['allergy'],
      plan: map['plan'] ?? '',
      mealTypes: List<String>.from(map['mealTypes'] ?? []),
      deliveryDays: List<String>.from(map['deliveryDays'] ?? []),
      totalPrice: (map['totalPrice'] ?? 0).toDouble(),
      status: map['status'] ?? 'aktif',
      createdAt:
          map['createdAt'] != null
              ? (map['createdAt'] is DateTime
                  ? map['createdAt']
                  : (map['createdAt'] as Timestamp).toDate())
              : null,
    );
  }

  // Tambahkan konversi dari entity ke model
  factory SubscriptionModel.fromEntity(Subscription entity) {
    return SubscriptionModel(
      id: entity.id,
      userId: entity.userId,
      name: entity.name,
      phone: entity.phone,
      allergy: entity.allergy,
      plan: entity.plan,
      mealTypes: entity.mealTypes,
      deliveryDays: entity.deliveryDays,
      totalPrice: entity.totalPrice,
      status: entity.status,
      createdAt: entity.createdAt,
    );
  }

  // Tambahkan konversi dari model ke entity
  Subscription toEntity() {
    return Subscription(
      id: id,
      userId: userId,
      name: name,
      phone: phone,
      allergy: allergy,
      plan: plan,
      mealTypes: mealTypes,
      deliveryDays: deliveryDays,
      totalPrice: totalPrice,
      status: status,
      createdAt: createdAt,
    );
  }
}
