import '../entities/auth.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Auth> call(String email, String password) {
    return repository.login(email, password);
  }
}