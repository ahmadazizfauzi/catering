import 'package:flutter/material.dart';
import '../../domain/usecases/save_testimonial_usecase.dart';
import '../../domain/usecases/get_all_testimonial_usecase.dart';
import '../../domain/entities/testimonial.dart';

class TestimonialProvider extends ChangeNotifier {
  final SaveTestimonialUsecase saveTestimonialUsecase;
  final GetAllTestimonialUsecase getAllTestimonialUsecase;

  bool isLoading = false;
  String? message;
  List<Testimonial> testimonials = [];

  TestimonialProvider(
    this.saveTestimonialUsecase,
    this.getAllTestimonialUsecase,
  );

  Future<void> save(Testimonial testimonial) async {
    isLoading = true;
    message = null;
    notifyListeners();
    try {
      await saveTestimonialUsecase(testimonial);
      message = "Testimonial berhasil dikirim!";
      await getAll(); // refresh list setelah kirim
    } catch (e) {
      message = "Gagal mengirim testimonial: $e";
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getAll() async {
    isLoading = true;
    notifyListeners();
    try {
      testimonials = await getAllTestimonialUsecase();
      message = null;
    } catch (e) {
      message = "Gagal memuat testimonial: $e";
    }
    isLoading = false;
    notifyListeners();
  }
}