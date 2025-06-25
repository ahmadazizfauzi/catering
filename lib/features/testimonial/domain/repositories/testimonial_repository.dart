import '../entities/testimonial.dart';

abstract class TestimonialRepository {
  Future<void> save(Testimonial testimonial);
  Future<List<Testimonial>> getAll();
}