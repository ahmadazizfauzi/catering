import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/profile_model.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImplementation implements ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;

  ProfileRepositoryImplementation(this.remoteDatasource);

  @override
  Future<void> saveProfile(Profile profile) {
    final model = ProfileModel.fromEntity(profile);
    return remoteDatasource.addProfile(model);
  }

  @override
  Future<Profile?> getCurrentProfile() async {
    final model = await remoteDatasource.getCurrentUserProfile();
    return model?.toEntity();
  }
}