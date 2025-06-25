import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/testimonial.dart';

class TestimonialModel {
  final String? id;
  final String name;
  final String message;
  final int rating;
  final String? photo;

  TestimonialModel({
    this.id,
    required this.name,
    required this.message,
    required this.rating,
    this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'message': message,
      'rating': rating,
      'photo': photo,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory TestimonialModel.fromMap(String id, Map<String, dynamic> map) {
    return TestimonialModel(
      id: id,
      name: map['name'] ?? '',
      message: map['message'] ?? '',
      rating: map['rating'] ?? 0,
      photo: map['photo'],
    );
  }

  factory TestimonialModel.fromEntity(Testimonial entity) {
    return TestimonialModel(
      id: entity.id,
      name: entity.name,
      message: entity.message,
      rating: entity.rating,
      photo: entity.photo,
    );
  }

  Testimonial toEntity() {
    return Testimonial(
      id: id,
      name: name,
      message: message,
      rating: rating,
      photo: photo,
    );
  }
}