class Testimonial {
  final String? id;
  final String name;
  final String message;
  final int rating;
  final String? photo;

  Testimonial({
    this.id,
    required this.name,
    required this.message,
    required this.rating,
    this.photo,
  });
}