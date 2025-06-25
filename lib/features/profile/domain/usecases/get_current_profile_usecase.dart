import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetCurrentProfileUsecase {
  final ProfileRepository repository;

  GetCurrentProfileUsecase(this.repository);

  Future<Profile?> call() {
    return repository.getCurrentProfile();
  }
}