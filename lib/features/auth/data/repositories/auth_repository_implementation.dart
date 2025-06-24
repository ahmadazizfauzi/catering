import '../../domain/entities/auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_model.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImplementation(this.remoteDatasource);

  @override
  Future<void> register(Auth auth, String password) {
    final model = AuthModel.fromEntity(auth);
    return remoteDatasource.register(model, password);
  }
}