class Auth {
  final String? id;
  final String email;
  final String name;
  final String? token;

  Auth({
    this.id,
    required this.email,
    required this.name,
    this.token,
  });
}