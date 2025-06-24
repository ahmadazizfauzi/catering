import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/subscription.dart';

class SubscriptionModel {
  final String? id;
  final String name;
  final String phone;
  final String? allergy;
  final String plan;
  final List<String> mealTypes;
  final List<String> deliveryDays;
  final double totalPrice;

  SubscriptionModel({
    this.id,
    required this.name,
    required this.phone,
    this.allergy,
    required this.plan,
    required this.mealTypes,
    required this.deliveryDays,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'allergy': allergy,
      'plan': plan,
      'mealTypes': mealTypes,
      'deliveryDays': deliveryDays,
      'totalPrice': totalPrice,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory SubscriptionModel.fromMap(String id, Map<String, dynamic> map) {
    return SubscriptionModel(
      id: id,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      allergy: map['allergy'],
      plan: map['plan'] ?? '',
      mealTypes: List<String>.from(map['mealTypes'] ?? []),
      deliveryDays: List<String>.from(map['deliveryDays'] ?? []),
      totalPrice: (map['totalPrice'] ?? 0).toDouble(),
    );
  }

  // Tambahkan konversi dari entity ke model
  factory SubscriptionModel.fromEntity(Subscription entity) {
    return SubscriptionModel(
      id: entity.id,
      name: entity.name,
      phone: entity.phone,
      allergy: entity.allergy,
      plan: entity.plan,
      mealTypes: entity.mealTypes,
      deliveryDays: entity.deliveryDays,
      totalPrice: entity.totalPrice,
    );
  }

  // Tambahkan konversi dari model ke entity
  Subscription toEntity() {
    return Subscription(
      id: id,
      name: name,
      phone: phone,
      allergy: allergy,
      plan: plan,
      mealTypes: mealTypes,
      deliveryDays: deliveryDays,
      totalPrice: totalPrice,
    );
  }
}