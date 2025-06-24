class Subscription {
  final String? id;
  final String name;
  final String phone;
  final String? allergy;
  final String plan;
  final List<String> mealTypes;
  final List<String> deliveryDays;
  final double totalPrice;

  Subscription({
    this.id,
    required this.name,
    required this.phone,
    this.allergy,
    required this.plan,
    required this.mealTypes,
    required this.deliveryDays,
    required this.totalPrice,
  });
}