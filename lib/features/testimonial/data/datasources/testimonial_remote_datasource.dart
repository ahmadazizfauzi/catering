import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/testimonial_model.dart';

class TestimonialRemoteDatasource {
  final _collection = FirebaseFirestore.instance.collection('testimonials');

  Future<void> addTestimonial(TestimonialModel testimonial) async {
    await _collection.add(testimonial.toMap());
  }

  Future<List<TestimonialModel>> getTestimonials() async {
    final snapshot = await _collection.orderBy('createdAt', descending: true).get();
    return snapshot.docs
        .map((doc) => TestimonialModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}