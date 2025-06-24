import 'package:catering_1/features/about/presentation/widgets/section/form_about_section.dart';
import 'package:flutter/material.dart';
import '../widgets/section/testimonial_about_section.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Kami')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [FormAboutSection(), TestimonialAboutSection()],
        ),
      ),
    );
  }
}
