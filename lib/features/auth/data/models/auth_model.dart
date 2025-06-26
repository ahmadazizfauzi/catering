import '../../domain/entities/auth.dart';

class AuthModel {
  final String? id;
  final String email;
  final String name;
  final String? token;
  final String role; 

  AuthModel({
    this.id,
    required this.email,
    required this.name,
    this.token,
    this.role = 'consumen',
  });

  factory AuthModel.fromEntity(Auth entity) {
    return AuthModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      token: entity.token,
      role: entity.role, 
    );
  }

  Auth toEntity() {
    return Auth(
      id: id,
      email: email,
      name: name,
      token: token,
      role: role, 
    );
  }
}
