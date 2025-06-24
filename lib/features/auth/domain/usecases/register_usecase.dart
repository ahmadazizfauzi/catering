import '../entities/auth.dart';
import '../repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<void> call(Auth auth, String password) {
    return repository.register(auth, password);
  }
}