import '../entities/testimonial.dart';
import '../repositories/testimonial_repository.dart';

class SaveTestimonialUsecase {
  final TestimonialRepository repository;

  SaveTestimonialUsecase(this.repository);

  Future<void> call(Testimonial testimonial) {
    return repository.save(testimonial);
  }
}