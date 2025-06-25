import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<void> saveProfile(Profile profile);
  Future<Profile?> getCurrentProfile();
}