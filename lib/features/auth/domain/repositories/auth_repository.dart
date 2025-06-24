import '../entities/auth.dart';

abstract class AuthRepository {
  Future<void> register(Auth auth, String password);
}