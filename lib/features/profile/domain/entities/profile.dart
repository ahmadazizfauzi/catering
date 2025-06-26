class Profile {
  final String? id;
  final String name;
  final String email;
  final String? photoUrl;
  final String role; 

  Profile({
    this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.role = 'consumen', 
  });
}
