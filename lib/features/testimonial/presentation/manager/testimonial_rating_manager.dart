// import 'package:flutter/material.dart';
// import '../../domain/entities/testimonial.dart';

// class TestimonialRatingManager {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController messageController = TextEditingController();
//   int rating = 5;
//   String? photo;

//   bool get isValid {
//     return nameController.text.trim().isNotEmpty &&
//         messageController.text.trim().isNotEmpty &&
//         rating > 0;
//   }

//   // UI hanya akses manager, tidak tahu entity
//   Testimonial toEntity() {
//     return Testimonial(
//       name: nameController.text.trim(),
//       message: messageController.text.trim(),
//       rating: rating,
//       photo: photo,
//     );
//   }

//   void dispose() {
//     nameController.dispose();
//     messageController.dispose();
//   }
// }