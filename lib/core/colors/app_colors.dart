import 'package:flutter/material.dart';

class AppColors {
  static const Map<String, Color> brand = {
    'default': Color(0xFF388E3C), // Hijau utama (Green 700)
    'light': Color(0xFFE8F5E9), // Hijau muda (Green 50)
    'dark': Color(0xFF1B5E20), // Hijau gelap (Green 900)
    'accent': Color.fromARGB(255, 0, 95, 227), // Hijau aksen (Green 600)
    'background': Color(0xFFFFFFFF), // Putih
    'text': Color(0xFF212121), // Abu gelap
    'modal': Color(0xFF43A047), // Hijau untuk modal alert (Green 600)
  };

  static const Map<String, Color> black = {'default': Color(0xFF000000)};

  static const Map<String, Color> white = {'default': Color(0xFFFFFFFF)};

  static const Map<String, Color> grey = {
    'default': Color(0xFFF5F5F5), // Abu muda (Grey 100)
    'light': Color(0xFFEEEEEE), // Abu lebih muda (Grey 200)
    'dark': Color(0xFF757575), // Abu gelap (Grey 600)
  };

  static const Map<String, Color> status = {
    'success': Color(0xFF43A047), // Hijau sukses (Green 600)
    'failed': Color(0xFFE53935), // Merah gagal (Red 600)
    'warning': Color(0xFFFFB300), // Kuning warning (Amber 600)
  };
}
