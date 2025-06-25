import '../../domain/entities/profile.dart';

class ProfileModel {
  final String? id;
  final String name;
  final String email;
  final String? photoUrl;

  ProfileModel({
    this.id,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'photoUrl': photoUrl};
  }

  factory ProfileModel.fromMap(String id, Map<String, dynamic> map) {
    return ProfileModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
    );
  }

  factory ProfileModel.fromEntity(Profile entity) {
    return ProfileModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      photoUrl: entity.photoUrl,
    );
  }

  Profile toEntity() {
    return Profile(id: id, name: name, email: email, photoUrl: photoUrl);
  }
}
