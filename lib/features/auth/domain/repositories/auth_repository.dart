import '../entities/auth.dart';

abstract class AuthRepository {
  Future<void> register(Auth auth, String password);
  Future<Auth> login(String email, String password);
   Future<void> logout();
}