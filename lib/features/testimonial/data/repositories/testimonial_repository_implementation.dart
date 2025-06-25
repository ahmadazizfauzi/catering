import '../../domain/entities/testimonial.dart';
import '../../domain/repositories/testimonial_repository.dart';
import '../models/testimonial_model.dart';
import '../datasources/testimonial_remote_datasource.dart';

class TestimonialRepositoryImplementation implements TestimonialRepository {
  final TestimonialRemoteDatasource remoteDatasource;

  TestimonialRepositoryImplementation(this.remoteDatasource);

  @override
  Future<void> save(Testimonial testimonial) {
    final model = TestimonialModel.fromEntity(testimonial);
    return remoteDatasource.addTestimonial(model);
  }

  @override
  Future<List<Testimonial>> getAll() async {
    final models = await remoteDatasource.getTestimonials();
    return models.map((m) => m.toEntity()).toList();
  }
}