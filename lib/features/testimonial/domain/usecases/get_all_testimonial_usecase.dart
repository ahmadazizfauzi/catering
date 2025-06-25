import '../entities/testimonial.dart';
import '../repositories/testimonial_repository.dart';

class GetAllTestimonialUsecase {
  final TestimonialRepository repository;

  GetAllTestimonialUsecase(this.repository);

  Future<List<Testimonial>> call() {
    return repository.getAll();
  }
}