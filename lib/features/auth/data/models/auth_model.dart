import '../../domain/entities/auth.dart';

class AuthModel {
  final String? id;
  final String email;
  final String name;
  final String? token;

  AuthModel({
    this.id,
    required this.email,
    required this.name,
    this.token,
  });

  factory AuthModel.fromEntity(Auth entity) {
    return AuthModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      token: entity.token,
    );
  }

  Auth toEntity() {
    return Auth(
      id: id,
      email: email,
      name: name,
      token: token,
    );
  }
}